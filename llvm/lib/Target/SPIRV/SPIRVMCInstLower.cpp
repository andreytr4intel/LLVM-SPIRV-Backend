//=- SPIRVMCInstLower.cpp - Convert SPIR-V MachineInstr to MCInst -*- C++ -*-=//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains code to lower SPIR-V MachineInstrs to their corresponding
// MCInst records.
//
//===----------------------------------------------------------------------===//

#include "SPIRVMCInstLower.h"
#include "SPIRV.h"
#include "SPIRVModuleAnalysis.h"
#include "SPIRVUtils.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/IR/Constants.h"

using namespace llvm;

// Defined in SPIRVAsmPrinter.cpp
extern Register getOrCreateMBBRegister(const MachineBasicBlock &MBB,
                                       ModuleAnalysisInfo *MAI);

void SPIRVMCInstLower::Lower(const MachineInstr *MI, MCInst &OutMI,
                             const MachineFunction *CurMF,
                             ModuleAnalysisInfo *MAI) const {
  OutMI.setOpcode(MI->getOpcode());
  const MachineFunction *MF = MI->getMF();
  for (unsigned i = 0, e = MI->getNumOperands(); i != e; ++i) {
    const MachineOperand &MO = MI->getOperand(i);
    // At this stage, SPIR-V should only have Register and Immediate operands
    MCOperand MCOp;
    switch (MO.getType()) {
    default:
      MI->print(errs());
      llvm_unreachable("unknown operand type");
    case MachineOperand::MO_GlobalAddress: {
      Register FuncReg = MAI->getFuncReg(MO.getGlobal()->getGlobalIdentifier());
      assert(FuncReg.isValid() && "Cannot find function Id");
      MCOp = MCOperand::createReg(FuncReg);
      break;
    }
    case MachineOperand::MO_MachineBasicBlock:
      MCOp = MCOperand::createReg(getOrCreateMBBRegister(*MO.getMBB(), MAI));
      break;
    case MachineOperand::MO_Register: {
      Register NewReg = MAI->getRegisterAlias(MF, MO.getReg());
      bool IsOldReg = !CurMF || !NewReg.isValid();
      MCOp = MCOperand::createReg(IsOldReg ? MO.getReg() : NewReg);
      break;
    }
    case MachineOperand::MO_Immediate:
      if (MI->getOpcode() == SPIRV::OpExtInst && i == 2) {
        Register Reg = MAI->getExtInstSetReg(MO.getImm());
        MCOp = MCOperand::createReg(Reg);
      } else {
        MCOp = MCOperand::createImm(MO.getImm());
      }
      break;
    case MachineOperand::MO_FPImmediate:
      MCOp = MCOperand::createDFPImm(
          MO.getFPImm()->getValueAPF().convertToFloat());
      break;
    }

    OutMI.addOperand(MCOp);
  }
}
