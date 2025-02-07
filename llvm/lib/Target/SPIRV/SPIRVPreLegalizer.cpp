//===-- SPIRVPreLegalizer.cpp - prepare IR for legalization -----*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// The pass prepares IR for legalization: it assigns SPIR-V types to registers
// and removes intrinsics which holded these types during IR translation.
// Also it processes constants and registers them in GR to avoid duplication.
//
//===----------------------------------------------------------------------===//

#include "SPIRV.h"
#include "SPIRVSubtarget.h"
#include "SPIRVUtils.h"
#include "llvm/ADT/PostOrderIterator.h"
#include "llvm/Analysis/OptimizationRemarkEmitter.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/IntrinsicsSPIRV.h"
#include "llvm/Target/TargetIntrinsicInfo.h"

#include <vector>

#define DEBUG_TYPE "spirv-prelegalizer"

using namespace llvm;

namespace {
class SPIRVPreLegalizer : public MachineFunctionPass {
public:
  static char ID;
  SPIRVPreLegalizer() : MachineFunctionPass(ID) {
    initializeSPIRVPreLegalizerPass(*PassRegistry::getPassRegistry());
  }
  bool runOnMachineFunction(MachineFunction &MF) override;
};
} // namespace

static bool isSpvIntrinsic(MachineInstr &MI, Intrinsic::ID IntrinsicID) {
  if (MI.getOpcode() == TargetOpcode::G_INTRINSIC_W_SIDE_EFFECTS &&
      MI.getIntrinsicID() == IntrinsicID)
    return true;
  return false;
}

static void addConstantsToTrack(MachineFunction &MF, SPIRVGlobalRegistry *GR) {
  auto &MRI = MF.getRegInfo();
  DenseMap<MachineInstr *, Register> RegsAlreadyAddedToDT;
  std::vector<MachineInstr *> ToErase, ToEraseComposites;
  for (auto &MBB : MF) {
    for (auto &MI : MBB) {
      if (isSpvIntrinsic(MI, Intrinsic::spv_track_constant)) {
        ToErase.push_back(&MI);
        auto *Const =
            cast<Constant>(cast<ConstantAsMetadata>(
                               MI.getOperand(3).getMetadata()->getOperand(0))
                               ->getValue());
        Register Reg;
        if (auto *GV = dyn_cast<GlobalValue>(Const)) {
          if (GR->find(GV, &MF, Reg) == false) {
            GR->add(GV, &MF, MI.getOperand(2).getReg());
          } else
            RegsAlreadyAddedToDT[&MI] = Reg;
        } else {
          if (GR->find(Const, &MF, Reg) == false) {
            if (auto *ConstVec = dyn_cast<ConstantDataVector>(Const)) {
              auto *BuildVec = MRI.getVRegDef(MI.getOperand(2).getReg());
              assert(BuildVec &&
                     BuildVec->getOpcode() == TargetOpcode::G_BUILD_VECTOR);
              for (unsigned i = 0; i < ConstVec->getNumElements(); ++i)
                GR->add(ConstVec->getElementAsConstant(i), &MF,
                        BuildVec->getOperand(1 + i).getReg());
            }
            GR->add(Const, &MF, MI.getOperand(2).getReg());
          } else {
            RegsAlreadyAddedToDT[&MI] = Reg;
            // This MI is unused and will be removed. If the MI uses
            // const_composite, it will be unused and should be removed too.
            assert(MI.getOperand(2).isReg() && "Reg operand is expected");
            MachineInstr *SrcMI = MRI.getVRegDef(MI.getOperand(2).getReg());
            if (SrcMI && isSpvIntrinsic(*SrcMI, Intrinsic::spv_const_composite))
              ToEraseComposites.push_back(SrcMI);
          }
        }
      }
    }
  }
  for (auto *MI : ToErase) {
    Register Reg = MI->getOperand(2).getReg();
    if (RegsAlreadyAddedToDT.find(MI) != RegsAlreadyAddedToDT.end())
      Reg = RegsAlreadyAddedToDT[MI];
    MRI.replaceRegWith(MI->getOperand(0).getReg(), Reg);
    MI->eraseFromParent();
  }
  for (auto *MI : ToEraseComposites)
    MI->eraseFromParent();
}

static std::map<Intrinsic::ID, unsigned> IntrsWConstsToFold = {
    {Intrinsic::spv_assign_name, 2},
    // {Intrinsic::spv_const_composite, 1}
};

static void foldConstantsIntoIntrinsics(MachineFunction &MF) {
  std::vector<MachineInstr *> ToErase;
  auto &MRI = MF.getRegInfo();
  for (auto &MBB : MF) {
    for (auto &MI : MBB) {
      if (MI.getOpcode() == TargetOpcode::G_INTRINSIC_W_SIDE_EFFECTS &&
          IntrsWConstsToFold.count(MI.getIntrinsicID())) {
        while (MI.getOperand(MI.getNumExplicitDefs() +
                             IntrsWConstsToFold.at(MI.getIntrinsicID()))
                   .isReg()) {
          auto MOp = MI.getOperand(MI.getNumExplicitDefs() +
                                   IntrsWConstsToFold.at(MI.getIntrinsicID()));
          auto *ConstMI = MRI.getVRegDef(MOp.getReg());
          assert(ConstMI->getOpcode() == TargetOpcode::G_CONSTANT);
          MI.RemoveOperand(MI.getNumExplicitDefs() +
                           IntrsWConstsToFold.at(MI.getIntrinsicID()));
          MI.addOperand(MachineOperand::CreateImm(
              ConstMI->getOperand(1).getCImm()->getZExtValue()));
          if (MRI.use_empty(ConstMI->getOperand(0).getReg()))
            ToErase.push_back(ConstMI);
        }
      }
    }
  }
  for (auto *MI : ToErase)
    MI->eraseFromParent();
}

static void insertBitcasts(MachineFunction &MF, SPIRVGlobalRegistry *GR) {
  std::vector<MachineInstr *> ToErase;
  MachineIRBuilder MIB(MF);
  for (auto &MBB : MF)
    for (auto &MI : MBB)
      if (isSpvIntrinsic(MI, Intrinsic::spv_bitcast)) {
        assert(MI.getOperand(2).isReg());
        MIB.setInsertPt(*MI.getParent(), MI);
        MIB.buildBitcast(MI.getOperand(0).getReg(), MI.getOperand(2).getReg());
        ToErase.push_back(&MI);
      }
  for (auto *MI : ToErase)
    MI->eraseFromParent();
}

// Translating GV, IRTranslator sometimes generates following IR:
//   %1 = G_GLOBAL_VALUE
//   %2 = COPY %1
//   %3 = G_ADDRSPACE_CAST %2
// New registers have no SPIRVType and no register class info.
//
// Set SPIRVType for GV, propagate it from GV to other instructions,
// also set register classes.
static SPIRVType *propagateSPIRVType(MachineInstr *MI, SPIRVGlobalRegistry *GR,
                                     MachineRegisterInfo &MRI,
                                     MachineIRBuilder &MIB) {
  SPIRVType *SpirvTy = nullptr;
  assert(MI && "Machine instr is expected");
  if (MI->getOperand(0).isReg()) {
    auto Reg = MI->getOperand(0).getReg();
    SpirvTy = GR->getSPIRVTypeForVReg(Reg);
    if (!SpirvTy) {
      switch (MI->getOpcode()) {
      case TargetOpcode::G_CONSTANT: {
        MIB.setInsertPt(*MI->getParent(), MI);
        Type *Ty = MI->getOperand(1).getCImm()->getType();
        SpirvTy = GR->getOrCreateSPIRVType(Ty, MIB);
        break;
      }
      case TargetOpcode::G_GLOBAL_VALUE: {
        MIB.setInsertPt(*MI->getParent(), MI);
        Type *Ty = MI->getOperand(1).getGlobal()->getType();
        SpirvTy = GR->getOrCreateSPIRVType(Ty, MIB);
        break;
      }
      case TargetOpcode::G_TRUNC:
      case TargetOpcode::G_ADDRSPACE_CAST:
      case TargetOpcode::COPY: {
        auto Op = MI->getOperand(1);
        auto *Def = Op.isReg() ? MRI.getVRegDef(Op.getReg()) : nullptr;
        if (Def)
          SpirvTy = propagateSPIRVType(Def, GR, MRI, MIB);
        break;
      }
      default:
        break;
      }
      if (SpirvTy)
        GR->assignSPIRVTypeToVReg(SpirvTy, Reg, MIB);
      if (!MRI.getRegClassOrNull(Reg))
        MRI.setRegClass(Reg, &SPIRV::IDRegClass);
    }
  }
  return SpirvTy;
}

// Insert ASSIGN_TYPE instuction between Reg and its definition, set NewReg as
// a dst of the definition, assign SPIRVType to both registers. If SpirvTy is
// provided, use it as SPIRVType in ASSIGN_TYPE, otherwise create it from Ty.
// It's used also in SPIRVOpenCLBIFs.cpp.
Register insertAssignInstr(Register Reg, Type *Ty, SPIRVType *SpirvTy,
                           SPIRVGlobalRegistry *GR, MachineIRBuilder &MIB,
                           MachineRegisterInfo &MRI) {
  MachineInstr *Def = MRI.getVRegDef(Reg);
  assert((Ty || SpirvTy) && "Either LLVM or SPIRV type is expected.");
  MIB.setInsertPt(*Def->getParent(),
                  (Def->getNextNode() ? Def->getNextNode()->getIterator()
                                      : Def->getParent()->end()));
  Register NewReg = MRI.createGenericVirtualRegister(MRI.getType(Reg));
  if (auto *RC = MRI.getRegClassOrNull(Reg))
    MRI.setRegClass(NewReg, RC);
  SpirvTy = SpirvTy ? SpirvTy : GR->getOrCreateSPIRVType(Ty, MIB);
  GR->assignSPIRVTypeToVReg(SpirvTy, Reg, MIB);
  // This is to make it convenient for Legalizer to get the SPIRVType
  // when processing the actual MI (i.e. not pseudo one).
  GR->assignSPIRVTypeToVReg(SpirvTy, NewReg, MIB);
  auto NewMI = MIB.buildInstr(SPIRV::ASSIGN_TYPE)
                   .addDef(Reg)
                   .addUse(NewReg)
                   .addUse(GR->getSPIRVTypeID(SpirvTy));
  Def->getOperand(0).setReg(NewReg);
  constrainRegOperands(NewMI, &MIB.getMF());
  return NewReg;
}

static void generateAssignInstrs(MachineFunction &MF, SPIRVGlobalRegistry *GR) {
  MachineIRBuilder MIB(MF);
  MachineRegisterInfo &MRI = MF.getRegInfo();
  std::vector<MachineInstr *> ToDelete;

  for (MachineBasicBlock *MBB : post_order(&MF)) {
    if (MBB->empty())
      continue;

    bool ReachedBegin = false;
    for (auto MII = std::prev(MBB->end()), Begin = MBB->begin();
         !ReachedBegin;) {
      MachineInstr &MI = *MII;

      if (isSpvIntrinsic(MI, Intrinsic::spv_assign_type)) {
        auto Reg = MI.getOperand(1).getReg();
        auto *Ty =
            cast<ValueAsMetadata>(MI.getOperand(2).getMetadata()->getOperand(0))
                ->getType();
        auto *Def = MRI.getVRegDef(Reg);
        assert(Def && "Expecting an instruction that defines the register");
        // G_GLOBAL_VALUE already has type info.
        if (Def->getOpcode() != TargetOpcode::G_GLOBAL_VALUE)
          insertAssignInstr(Reg, Ty, nullptr, GR, MIB, MF.getRegInfo());
        ToDelete.push_back(&MI);
      } else if (MI.getOpcode() == TargetOpcode::G_CONSTANT ||
                 MI.getOpcode() == TargetOpcode::G_FCONSTANT ||
                 MI.getOpcode() == TargetOpcode::G_BUILD_VECTOR) {
        // %rc = G_CONSTANT ty Val
        // ===>
        // %cty = OpType* ty
        // %rctmp = G_CONSTANT ty Val
        // %rc = ASSIGN_TYPE %rctmp, %cty
        auto Reg = MI.getOperand(0).getReg();
        if (MRI.hasOneUse(Reg)) {
          MachineInstr &UseMI = *MRI.use_instr_begin(Reg);
          if (isSpvIntrinsic(UseMI, Intrinsic::spv_assign_type) ||
              isSpvIntrinsic(UseMI, Intrinsic::spv_assign_name))
            continue;
        }
        auto &MRI = MF.getRegInfo();
        Type *Ty = nullptr;
        if (MI.getOpcode() == TargetOpcode::G_CONSTANT)
          Ty = MI.getOperand(1).getCImm()->getType();
        else if (MI.getOpcode() == TargetOpcode::G_FCONSTANT)
          Ty = MI.getOperand(1).getFPImm()->getType();
        else {
          assert(MI.getOpcode() == TargetOpcode::G_BUILD_VECTOR);
          Type *ElemTy = nullptr;
          auto *ElemMI = MRI.getVRegDef(MI.getOperand(1).getReg());
          assert(ElemMI);

          if (ElemMI->getOpcode() == TargetOpcode::G_CONSTANT)
            ElemTy = ElemMI->getOperand(1).getCImm()->getType();
          else if (ElemMI->getOpcode() == TargetOpcode::G_FCONSTANT)
            ElemTy = ElemMI->getOperand(1).getFPImm()->getType();
          else
            assert(0);
          Ty = VectorType::get(
              ElemTy, MI.getNumExplicitOperands() - MI.getNumExplicitDefs(),
              false);
        }
        insertAssignInstr(Reg, Ty, nullptr, GR, MIB, MRI);
      } else if (MI.getOpcode() == TargetOpcode::G_TRUNC ||
                 MI.getOpcode() == TargetOpcode::G_GLOBAL_VALUE ||
                 MI.getOpcode() == TargetOpcode::COPY ||
                 MI.getOpcode() == TargetOpcode::G_ADDRSPACE_CAST) {
        propagateSPIRVType(&MI, GR, MRI, MIB);
      }

      if (MII == Begin)
        ReachedBegin = true;
      else
        --MII;
    }
  }

  for (auto &MI : ToDelete)
    MI->eraseFromParent();
}

static std::pair<Register, unsigned>
createNewIdReg(Register ValReg, unsigned Opcode, MachineRegisterInfo &MRI,
               const SPIRVGlobalRegistry &GR) {
  auto NewT = LLT::scalar(32);
  auto SpvType = GR.getSPIRVTypeForVReg(ValReg);
  assert(SpvType && "VReg is expected to have SPIRV type");
  bool IsFloat = SpvType->getOpcode() == SPIRV::OpTypeFloat;
  bool IsVectorFloat =
      SpvType->getOpcode() == SPIRV::OpTypeVector &&
      GR.getSPIRVTypeForVReg(SpvType->getOperand(1).getReg())->getOpcode() ==
          SPIRV::OpTypeFloat;
  IsFloat |= IsVectorFloat;
  auto GetIdOp = IsFloat ? SPIRV::GET_fID : SPIRV::GET_ID;
  auto DstClass = IsFloat ? &SPIRV::fIDRegClass : &SPIRV::IDRegClass;
  if (MRI.getType(ValReg).isPointer()) {
    NewT = LLT::pointer(0, 32);
    GetIdOp = SPIRV::GET_pID;
    DstClass = &SPIRV::pIDRegClass;
  } else if (MRI.getType(ValReg).isVector()) {
    NewT = LLT::fixed_vector(2, NewT);
    GetIdOp = IsFloat ? SPIRV::GET_vfID : SPIRV::GET_vID;
    DstClass = IsFloat ? &SPIRV::vfIDRegClass : &SPIRV::vIDRegClass;
  }
  auto IdReg = MRI.createGenericVirtualRegister(NewT);
  MRI.setRegClass(IdReg, DstClass);
  return {IdReg, GetIdOp};
}

static void processInstr(MachineInstr &MI, MachineIRBuilder &MIB,
                         MachineRegisterInfo &MRI, SPIRVGlobalRegistry *GR) {
  auto Opc = MI.getOpcode();
  assert(MI.getNumDefs() > 0 && MRI.hasOneUse(MI.getOperand(0).getReg()));
  MachineInstr &AssignTypeInst =
      *(MRI.use_instr_begin(MI.getOperand(0).getReg()));
  auto NewReg = createNewIdReg(MI.getOperand(0).getReg(), Opc, MRI, *GR).first;
  AssignTypeInst.getOperand(1).setReg(NewReg);
  // MRI.setRegClass(AssignTypeInst.getOperand(0).getReg(),
  // MRI.getRegClass(NewReg));
  MI.getOperand(0).setReg(NewReg);
  MIB.setInsertPt(*MI.getParent(),
                  (MI.getNextNode() ? MI.getNextNode()->getIterator()
                                    : MI.getParent()->end()));
  for (auto &Op : MI.operands()) {
    if (!Op.isReg() || Op.isDef())
      continue;
    // if (Ids.count(&Op) > 0) {
    //   Op.setReg(Ids.at(&Op));
    //   // NewI.addUse(Ids.at(&Op));
    // } else {
    auto IdOpInfo = createNewIdReg(Op.getReg(), Opc, MRI, *GR);
    MIB.buildInstr(IdOpInfo.second).addDef(IdOpInfo.first).addUse(Op.getReg());
    // Ids[&Op] = IdOpInfo.first;
    Op.setReg(IdOpInfo.first);
    // }
  }
}

// Defined in SPIRVLegalizerInfo.cpp
extern bool isTypeFoldingSupported(unsigned Opcode);

static void processInstrsWithTypeFolding(MachineFunction &MF,
                                         SPIRVGlobalRegistry *GR) {
  MachineIRBuilder MIB(MF);
  auto &MRI = MF.getRegInfo();
  for (auto &MBB : MF)
    for (auto &MI : MBB)
      if (isTypeFoldingSupported(MI.getOpcode()))
        processInstr(MI, MIB, MRI, GR);
}

bool SPIRVPreLegalizer::runOnMachineFunction(MachineFunction &MF) {
  // Initialize the type registry
  const auto *ST = static_cast<const SPIRVSubtarget *>(&MF.getSubtarget());
  SPIRVGlobalRegistry *GR = ST->getSPIRVGlobalRegistry();
  GR->setCurrentFunc(MF);
  addConstantsToTrack(MF, GR);
  foldConstantsIntoIntrinsics(MF);
  insertBitcasts(MF, GR);
  generateAssignInstrs(MF, GR);
  processInstrsWithTypeFolding(MF, GR);

  return true;
}

INITIALIZE_PASS(SPIRVPreLegalizer, DEBUG_TYPE, "SPIRV pre legalizer", false,
                false)

char SPIRVPreLegalizer::ID = 0;

FunctionPass *llvm::createSPIRVPreLegalizerPass() {
  return new SPIRVPreLegalizer();
}
