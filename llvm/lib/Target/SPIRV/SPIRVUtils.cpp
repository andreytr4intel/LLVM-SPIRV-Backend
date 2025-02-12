//===--- SPIRVUtils.cpp ---- SPIR-V Utility Functions -----------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains miscellaneous utility functions.
//
//===----------------------------------------------------------------------===//

#include "SPIRVUtils.h"
#include "SPIRV.h"
#include "SPIRVStringReader.h"

using namespace llvm;

// The following functions are used to add these string literals as a series of
// 32-bit integer operands with the correct format, and unpack them if necessary
// when making string comparisons in compiler passes.
// SPIR-V requires null-terminated UTF-8 strings padded to 32-bit alignment.
static uint32_t convertCharsToWord(const StringRef &Str, unsigned i) {
  uint32_t Word = 0u; // Build up this 32-bit word from 4 8-bit chars
  for (unsigned WordIndex = 0; WordIndex < 4; ++WordIndex) {
    unsigned StrIndex = i + WordIndex;
    uint8_t CharToAdd = 0;       // Initilize char as padding/null
    if (StrIndex < Str.size()) { // If it's within the string, get a real char
      CharToAdd = Str[StrIndex];
    }
    Word |= (CharToAdd << (WordIndex * 8));
  }
  return Word;
}

// Get length including padding and null terminator.
static size_t getPaddedLen(const StringRef &Str) {
  const size_t Len = Str.size() + 1;
  return (Len % 4 == 0) ? Len : Len + (4 - (Len % 4));
}

void addStringImm(const StringRef &Str, MCInst &Inst) {
  const size_t PaddedLen = getPaddedLen(Str);
  for (unsigned i = 0; i < PaddedLen; i += 4) {
    // Add an operand for the 32-bits of chars or padding
    Inst.addOperand(MCOperand::createImm(convertCharsToWord(Str, i)));
  }
}

void addStringImm(const StringRef &Str, MachineInstrBuilder &MIB) {
  const size_t PaddedLen = getPaddedLen(Str);
  for (unsigned i = 0; i < PaddedLen; i += 4) {
    // Add an operand for the 32-bits of chars or padding
    MIB.addImm(convertCharsToWord(Str, i));
  }
}

void addStringImm(const StringRef &Str, IRBuilder<> &B,
                  std::vector<Value *> &Args) {
  const size_t PaddedLen = getPaddedLen(Str);
  for (unsigned i = 0; i < PaddedLen; i += 4) {
    // Add a vector element for the 32-bits of chars or padding
    Args.push_back(B.getInt32(convertCharsToWord(Str, i)));
  }
}

std::string getStringImm(const MachineInstr &MI, unsigned int StartIndex) {
  return getSPIRVStringOperand(MI, StartIndex);
}

void addNumImm(const APInt &Imm, MachineInstrBuilder &MIB, bool IsFloat) {
  const auto Bitwidth = Imm.getBitWidth();
  switch (Bitwidth) {
  case 1:
    break; // Already handled
  case 8:
  case 16:
  case 32:
    MIB.addImm(Imm.getZExtValue());
    break;
  case 64: {
    uint64_t FullImm = Imm.getZExtValue();
    uint32_t LowBits = FullImm & 0xffffffff;
    uint32_t HighBits = (FullImm >> 32) & 0xffffffff;
    MIB.addImm(LowBits).addImm(HighBits);
    break;
  }
  default:
    report_fatal_error("Unsupported constant bitwidth");
  }
}

void buildOpName(Register Target, const StringRef &Name,
                 MachineIRBuilder &MIRBuilder) {
  if (!Name.empty()) {
    auto MIB = MIRBuilder.buildInstr(SPIRV::OpName).addUse(Target);
    addStringImm(Name, MIB);
  }
}

void buildOpDecorate(Register Reg, MachineIRBuilder &MIRBuilder,
                     Decoration::Decoration Dec,
                     const std::vector<uint32_t> &DecArgs, StringRef StrImm) {
  auto MIB = MIRBuilder.buildInstr(SPIRV::OpDecorate).addUse(Reg).addImm(Dec);
  if (!StrImm.empty())
    addStringImm(StrImm, MIB);
  for (const auto &DecArg : DecArgs)
    MIB.addImm(DecArg);
}

// TODO: maybe the following two functions should be handled in the subtarget
// to allow for different OpenCL vs Vulkan handling.
unsigned int storageClassToAddressSpace(StorageClass::StorageClass SC) {
  switch (SC) {
  case StorageClass::Function:
    return 0;
  case StorageClass::CrossWorkgroup:
    return 1;
  case StorageClass::UniformConstant:
    return 2;
  case StorageClass::Workgroup:
    return 3;
  case StorageClass::Generic:
    return 4;
  case StorageClass::Input:
    return 7;
  default:
    llvm_unreachable("Unable to get address space id");
  }
}

StorageClass::StorageClass addressSpaceToStorageClass(unsigned int AddrSpace) {
  switch (AddrSpace) {
  case 0:
    return StorageClass::Function;
  case 1:
    return StorageClass::CrossWorkgroup;
  case 2:
    return StorageClass::UniformConstant;
  case 3:
    return StorageClass::Workgroup;
  case 4:
    return StorageClass::Generic;
  case 7:
    return StorageClass::Input;
  default:
    llvm_unreachable("Unknown address space");
  }
}

MemorySemantics::MemorySemantics
getMemSemanticsForStorageClass(StorageClass::StorageClass sc) {
  switch (sc) {
  case StorageClass::StorageBuffer:
  case StorageClass::Uniform:
    return MemorySemantics::UniformMemory;
  case StorageClass::Workgroup:
    return MemorySemantics::WorkgroupMemory;
  case StorageClass::CrossWorkgroup:
    return MemorySemantics::CrossWorkgroupMemory;
  case StorageClass::AtomicCounter:
    return MemorySemantics::AtomicCounterMemory;
  case StorageClass::Image:
    return MemorySemantics::ImageMemory;
  default:
    return MemorySemantics::None;
  }
}

bool constrainRegOperands(MachineInstrBuilder &MIB, MachineFunction *MF) {
  if (!MF)
    MF = MIB->getMF();
  const auto &Subtarget = MF->getSubtarget();
  const TargetInstrInfo *TII = Subtarget.getInstrInfo();
  const TargetRegisterInfo *TRI = Subtarget.getRegisterInfo();
  const RegisterBankInfo *RBI = Subtarget.getRegBankInfo();

  return constrainSelectedInstRegOperands(*MIB, *TII, *TRI, *RBI);
}
