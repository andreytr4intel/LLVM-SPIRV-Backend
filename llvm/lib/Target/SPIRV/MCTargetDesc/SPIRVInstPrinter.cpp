//===-- SPIRVInstPrinter.cpp - Output SPIR-V MCInsts as ASM -----*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This class prints a SPIR-V MCInst to a .s file.
//
//===----------------------------------------------------------------------===//

#include "SPIRVInstPrinter.h"
#include "llvm/CodeGen/Register.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCInstrInfo.h"
#include "llvm/MC/MCSymbol.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/FormattedStream.h"

#include "SPIRV.h"
#include "SPIRVEnums.h"
#include "SPIRVExtInsts.h"
#include "SPIRVStringReader.h"

using namespace llvm;

#define DEBUG_TYPE "asm-printer"

// Include the auto-generated portion of the assembly writer.
#include "SPIRVGenAsmWriter.inc"

void SPIRVInstPrinter::printRemainingVariableOps(const MCInst *MI,
                                                 unsigned StartIndex,
                                                 raw_ostream &O,
                                                 bool SkipFirstSpace,
                                                 bool SkipImmediates) {
  const unsigned int NumOps = MI->getNumOperands();
  for (unsigned int i = StartIndex; i < NumOps; ++i) {
    if (!SkipImmediates || !MI->getOperand(i).isImm()) {
      if (!SkipFirstSpace || i != StartIndex)
        O << ' ';
      printOperand(MI, i, O);
    }
  }
}

void SPIRVInstPrinter::printOpConstantVarOps(const MCInst *MI,
                                             unsigned StartIndex,
                                             raw_ostream &O) {
  O << ' ';
  if (MI->getNumOperands() - StartIndex == 2) { // Handle 64 bit literals
    uint64_t Imm = MI->getOperand(StartIndex).getImm();
    Imm |= (MI->getOperand(StartIndex + 1).getImm() << 32);
    O << Imm;
  } else {
    printRemainingVariableOps(MI, StartIndex, O, true, false);
  }
}

void SPIRVInstPrinter::recordOpExtInstImport(const MCInst *MI) {
  Register Reg = MI->getOperand(0).getReg();
  auto Name = getSPIRVStringOperand(*MI, 1);
  auto Set = getExtInstSetFromString(Name);
  ExtInstSetIDs.insert({Reg, Set});
}

void SPIRVInstPrinter::printInst(const MCInst *MI, uint64_t Address,
                                 StringRef Annot, const MCSubtargetInfo &STI,
                                 raw_ostream &OS) {
  const unsigned int OpCode = MI->getOpcode();
  printInstruction(MI, Address, OS);

  if (OpCode == SPIRV::OpDecorate) {
    printOpDecorate(MI, OS);
  } else if (OpCode == SPIRV::OpExtInstImport) {
    recordOpExtInstImport(MI);
  } else if (OpCode == SPIRV::OpExtInst) {
    printOpExtInst(MI, OS);
  } else {
    // Print any extra operands for variadic instructions
    MCInstrDesc MCDesc = MII.get(OpCode);
    if (MCDesc.isVariadic()) {
      const unsigned NumFixedOps = MCDesc.getNumOperands();
      const unsigned LastFixedIndex = NumFixedOps - 1;
      const int FirstVariableIndex = NumFixedOps;
      if (NumFixedOps > 0 &&
          MCDesc.OpInfo[LastFixedIndex].OperandType == MCOI::OPERAND_UNKNOWN) {
        // For instructions where a custom type (not reg or immediate) comes as
        // the last operand before the variable_ops. This is usually a StringImm
        // operand, but there are a few other cases.
        switch (OpCode) {
        case SPIRV::OpTypeImage:
          OS << ' ';
          printAccessQualifier(MI, FirstVariableIndex, OS);
          break;
        case SPIRV::OpVariable:
          OS << ' ';
          printOperand(MI, FirstVariableIndex, OS);
          break;
        case SPIRV::OpEntryPoint: {
          // Print the interface ID operands, skipping the name's string literal
          printRemainingVariableOps(MI, NumFixedOps, OS, false, true);
          break;
        }
        case SPIRV::OpExecutionMode:
        case SPIRV::OpExecutionModeId:
        case SPIRV::OpLoopMerge: {
          // Print any literals after the OPERAND_UNKNOWN argument normally
          printRemainingVariableOps(MI, NumFixedOps, OS);
          break;
        }
        default:
          break; // printStringImm has already been handled
        }
      } else {
        // For instructions with no fixed ops or a reg/immediate as the final
        // fixed operand, we can usually print the rest with "printOperand", but
        // check for a few cases with custom types first.
        switch (OpCode) {
        case SPIRV::OpLoad:
        case SPIRV::OpStore:
          OS << ' ';
          printMemoryOperand(MI, FirstVariableIndex, OS);
          printRemainingVariableOps(MI, FirstVariableIndex + 1, OS);
          break;
        case SPIRV::OpImageSampleImplicitLod:
        case SPIRV::OpImageSampleDrefImplicitLod:
        case SPIRV::OpImageSampleProjImplicitLod:
        case SPIRV::OpImageSampleProjDrefImplicitLod:
        case SPIRV::OpImageFetch:
        case SPIRV::OpImageGather:
        case SPIRV::OpImageDrefGather:
        case SPIRV::OpImageRead:
        case SPIRV::OpImageWrite:
        case SPIRV::OpImageSparseSampleImplicitLod:
        case SPIRV::OpImageSparseSampleDrefImplicitLod:
        case SPIRV::OpImageSparseSampleProjImplicitLod:
        case SPIRV::OpImageSparseSampleProjDrefImplicitLod:
        case SPIRV::OpImageSparseFetch:
        case SPIRV::OpImageSparseGather:
        case SPIRV::OpImageSparseDrefGather:
        case SPIRV::OpImageSparseRead:
        case SPIRV::OpImageSampleFootprintNV:
          OS << ' ';
          printImageOperand(MI, FirstVariableIndex, OS);
          printRemainingVariableOps(MI, NumFixedOps + 1, OS);
          break;
        case SPIRV::OpCopyMemory:
        case SPIRV::OpCopyMemorySized: {
          const unsigned int NumOps = MI->getNumOperands();
          for (unsigned int i = NumFixedOps; i < NumOps; ++i) {
            OS << ' ';
            printMemoryOperand(MI, i, OS);
            if (MI->getOperand(i).getImm() & MemoryOperand::Aligned) {
              assert(i + 1 < NumOps && "Missing alignment operand");
              OS << ' ';
              printOperand(MI, i + 1, OS);
              i += 1;
            }
          }
          break;
        }
        case SPIRV::OpConstantI:
        case SPIRV::OpConstantF:
          printOpConstantVarOps(MI, NumFixedOps, OS);
          break;
        default:
          printRemainingVariableOps(MI, NumFixedOps, OS);
          break;
        }
      }
    }
  }

  printAnnotation(OS, Annot);
}

void SPIRVInstPrinter::printOpExtInst(const MCInst *MI, raw_ostream &O) {
  // The fixed operands have already been printed, so just need to decide what
  // type of ExtInst operands to print based on the instruction set and number.
  MCInstrDesc MCDesc = MII.get(MI->getOpcode());
  unsigned int NumFixedOps = MCDesc.getNumOperands();
  const auto NumOps = MI->getNumOperands();
  if (NumOps == NumFixedOps)
    return;

  O << ' ';

  auto SetReg = MI->getOperand(2).getReg();
  auto Set = ExtInstSetIDs[SetReg];
  if (Set == ExtInstSet::OpenCL_std) {
    auto Inst = static_cast<OpenCL_std::OpenCL_std>(MI->getOperand(3).getImm());
    switch (Inst) {
    case OpenCL_std::vstore_half_r:
    case OpenCL_std::vstore_halfn_r:
    case OpenCL_std::vstorea_halfn_r: {
      // These ops have a literal FPRoundingMode as the last arg
      for (unsigned int i = NumFixedOps; i < NumOps - 1; ++i) {
        printOperand(MI, i, O);
        O << ' ';
      }
      printFPRoundingMode(MI, NumOps - 1, O);
      break;
    }
    default:
      printRemainingVariableOps(MI, NumFixedOps, O, true);
    }
  } else {
    printRemainingVariableOps(MI, NumFixedOps, O, true);
  }
}

void SPIRVInstPrinter::printOpDecorate(const MCInst *MI, raw_ostream &O) {
  // The fixed operands have already been printed, so just need to decide what
  // type of decoration operands to print based on the Decoration type.
  MCInstrDesc MCDesc = MII.get(MI->getOpcode());
  unsigned int NumFixedOps = MCDesc.getNumOperands();

  if (NumFixedOps != MI->getNumOperands()) {
    auto DecOp = MI->getOperand(NumFixedOps - 1);
    auto Dec = static_cast<Decoration::Decoration>(DecOp.getImm());

    O << ' ';

    switch (Dec) {
    case Decoration::BuiltIn:
      printBuiltIn(MI, NumFixedOps, O);
      break;
    case Decoration::UniformId:
      printScope(MI, NumFixedOps, O);
      break;
    case Decoration::FuncParamAttr:
      printFunctionParameterAttribute(MI, NumFixedOps, O);
      break;
    case Decoration::FPRoundingMode:
      printFPRoundingMode(MI, NumFixedOps, O);
      break;
    case Decoration::FPFastMathMode:
      printFPFastMathMode(MI, NumFixedOps, O);
      break;
    case Decoration::LinkageAttributes:
      printStringImm(MI, NumFixedOps, O);
      break;
    default:
      printRemainingVariableOps(MI, NumFixedOps, O, true);
      break;
    }
  }
}

static void printExpr(const MCExpr *Expr, raw_ostream &O) {
#ifndef NDEBUG
  const MCSymbolRefExpr *SRE;

  if (const MCBinaryExpr *BE = dyn_cast<MCBinaryExpr>(Expr))
    SRE = dyn_cast<MCSymbolRefExpr>(BE->getLHS());
  else
    SRE = dyn_cast<MCSymbolRefExpr>(Expr);
  assert(SRE && "Unexpected MCExpr type.");

  MCSymbolRefExpr::VariantKind Kind = SRE->getKind();

  assert(Kind == MCSymbolRefExpr::VK_None);
#endif
  O << *Expr;
}

void SPIRVInstPrinter::printOperand(const MCInst *MI, unsigned OpNo,
                                    raw_ostream &O, const char *Modifier) {
  assert((Modifier == 0 || Modifier[0] == 0) && "No modifiers supported");
  if (OpNo < MI->getNumOperands()) {
    const MCOperand &Op = MI->getOperand(OpNo);
    if (Op.isReg()) {
      O << "%" << (Register::virtReg2Index(Op.getReg()) + 1);
    } else if (Op.isImm()) {
      O << formatImm((int64_t)Op.getImm());
    } else if (Op.isDFPImm()) {
      O << formatImm((double)Op.getDFPImm());
    } else {
      assert(Op.isExpr() && "Expected an expression");
      printExpr(Op.getExpr(), O);
    }
  }
}

void SPIRVInstPrinter::printStringImm(const MCInst *MI, unsigned OpNo,
                                      raw_ostream &O) {
  const unsigned NumOps = MI->getNumOperands();
  unsigned StrStartIndex = OpNo;
  while (StrStartIndex < NumOps) {
    if (MI->getOperand(StrStartIndex).isReg())
      break;

    std::string Str = getSPIRVStringOperand(*MI, OpNo);
    if (StrStartIndex != OpNo)
      O << ' '; // Add a space if we're starting a new string/argument
    O << '"';
    for (char c : Str) {
      if (c == '"')
        O.write('\\'); // Escape " characters (might break for complex UTF-8)
      O.write(c);
    }
    O << '"';

    unsigned numOpsInString = (Str.size() / 4) + 1;
    StrStartIndex += numOpsInString;

    // Check for final Op of "OpDecorate %x %stringImm %linkageAttribute"
    if (MI->getOpcode() == SPIRV::OpDecorate &&
        MI->getOperand(1).getImm() == Decoration::LinkageAttributes) {
      O << ' ';
      printLinkageType(MI, StrStartIndex, O);
      break;
    }
  }
}

void SPIRVInstPrinter::printExtInst(const MCInst *MI, unsigned OpNo,
                                    raw_ostream &O) {
  auto SetReg = MI->getOperand(2).getReg();
  auto Set = ExtInstSetIDs[SetReg];
  auto Op = MI->getOperand(OpNo).getImm();
  O << getExtInstName(Set, Op);
}

// Methods for printing textual names of SPIR-V enums (see SPIRVEnums.h)
GEN_INSTR_PRINTER_IMPL(Capability)
GEN_INSTR_PRINTER_IMPL(SourceLanguage)
GEN_INSTR_PRINTER_IMPL(ExecutionModel)
GEN_INSTR_PRINTER_IMPL(AddressingModel)
GEN_INSTR_PRINTER_IMPL(MemoryModel)
GEN_INSTR_PRINTER_IMPL(ExecutionMode)
GEN_INSTR_PRINTER_IMPL(StorageClass)
GEN_INSTR_PRINTER_IMPL(Dim)
GEN_INSTR_PRINTER_IMPL(SamplerAddressingMode)
GEN_INSTR_PRINTER_IMPL(SamplerFilterMode)
GEN_INSTR_PRINTER_IMPL(ImageFormat)
GEN_INSTR_PRINTER_IMPL(ImageChannelOrder)
GEN_INSTR_PRINTER_IMPL(ImageChannelDataType)
GEN_INSTR_PRINTER_IMPL(ImageOperand)
GEN_INSTR_PRINTER_IMPL(FPFastMathMode)
GEN_INSTR_PRINTER_IMPL(FPRoundingMode)
GEN_INSTR_PRINTER_IMPL(LinkageType)
GEN_INSTR_PRINTER_IMPL(AccessQualifier)
GEN_INSTR_PRINTER_IMPL(FunctionParameterAttribute)
GEN_INSTR_PRINTER_IMPL(Decoration)
GEN_INSTR_PRINTER_IMPL(BuiltIn)
GEN_INSTR_PRINTER_IMPL(SelectionControl)
GEN_INSTR_PRINTER_IMPL(LoopControl)
GEN_INSTR_PRINTER_IMPL(FunctionControl)
GEN_INSTR_PRINTER_IMPL(MemorySemantics)
GEN_INSTR_PRINTER_IMPL(MemoryOperand)
GEN_INSTR_PRINTER_IMPL(Scope)
GEN_INSTR_PRINTER_IMPL(GroupOperation)
GEN_INSTR_PRINTER_IMPL(KernelEnqueueFlags)
GEN_INSTR_PRINTER_IMPL(KernelProfilingInfo)
