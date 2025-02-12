//===-- SPIRVSubtarget.h - SPIR-V Subtarget Information --------*- C++ -*--===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file declares the SPIR-V specific subclass of TargetSubtargetInfo.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_SPIRV_SPIRVSUBTARGET_H
#define LLVM_LIB_TARGET_SPIRV_SPIRVSUBTARGET_H

#include "SPIRVCallLowering.h"
#include "SPIRVEnums.h"
#include "SPIRVExtInsts.h"
#include "SPIRVExtensions.h"
#include "SPIRVFrameLowering.h"
#include "SPIRVGlobalRegistry.h"
#include "SPIRVISelLowering.h"
#include "SPIRVInstrInfo.h"
#include "SPIRVRegisterBankInfo.h"
#include "llvm/CodeGen/GlobalISel/CallLowering.h"
#include "llvm/CodeGen/GlobalISel/InstructionSelector.h"
#include "llvm/CodeGen/GlobalISel/LegalizerInfo.h"
#include "llvm/CodeGen/GlobalISel/RegisterBankInfo.h"
#include "llvm/CodeGen/SelectionDAGTargetInfo.h"
#include "llvm/CodeGen/TargetSubtargetInfo.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/Target/TargetMachine.h"

#define GET_SUBTARGETINFO_HEADER
#include "SPIRVGenSubtargetInfo.inc"

namespace llvm {
class StringRef;

class SPIRVTargetMachine;
class SPIRVGlobalRegistry;

class SPIRVSubtarget : public SPIRVGenSubtargetInfo {
private:
  const unsigned int PointerSize;
  const bool UsesLogicalAddressing;
  const bool UsesVulkanEnv;
  const bool UsesOpenCLEnv;

  uint32_t TargetSPIRVVersion;
  uint32_t TargetOpenCLVersion;
  uint32_t TargetVulkanVersion;
  bool OpenCLFullProfile;
  bool OpenCLImageSupport;

  std::set<Extension::Extension> AvailableExtensions;
  std::set<ExtInstSet> AvailableExtInstSets;
  std::set<Capability::Capability> AvailableCaps;

  std::unique_ptr<SPIRVGlobalRegistry> GR;

  SPIRVInstrInfo InstrInfo;
  SPIRVFrameLowering FrameLowering;
  SPIRVTargetLowering TLInfo;

  // GlobalISel related APIs.
  std::unique_ptr<CallLowering> CallLoweringInfo;
  std::unique_ptr<RegisterBankInfo> RegBankInfo;
  std::unique_ptr<LegalizerInfo> Legalizer;
  std::unique_ptr<InstructionSelector> InstSelector;

private:
  // Initialise the available extensions, extended instruction sets and
  // capabilities based on the environment settings (i.e. the previous
  // properties of SPIRVSubtarget).
  //
  // These functions must be called in the order they are declared to satisfy
  // dependencies during initialisation.
  void initAvailableExtensions(const Triple &TT);
  void initAvailableExtInstSets(const Triple &TT);
  void initAvailableCapabilities(const Triple &TT);

public:
  // This constructor initializes the data members to match that
  // of the specified triple.
  SPIRVSubtarget(const Triple &TT, const std::string &CPU,
                 const std::string &FS, const SPIRVTargetMachine &TM);

  SPIRVSubtarget &initSubtargetDependencies(StringRef CPU, StringRef FS);

  // Parses features string setting specified subtarget options.
  //
  // The definition of this function is auto generated by tblgen.
  void ParseSubtargetFeatures(StringRef CPU, StringRef TuneCPU, StringRef FS);

  unsigned int getPointerSize() const { return PointerSize; }
  bool canDirectlyComparePointers() const;

  bool isLogicalAddressing() const;
  bool isKernel() const;
  bool isShader() const;

  uint32_t getTargetSPIRVVersion() const { return TargetSPIRVVersion; };

  bool canUseCapability(Capability::Capability C) const;
  bool canUseExtension(Extension::Extension E) const;
  bool canUseExtInstSet(ExtInstSet E) const;

  SPIRVGlobalRegistry *getSPIRVGlobalRegistry() const { return GR.get(); }

  const CallLowering *getCallLowering() const override {
    return CallLoweringInfo.get();
  }

  const RegisterBankInfo *getRegBankInfo() const override {
    return RegBankInfo.get();
  }

  const LegalizerInfo *getLegalizerInfo() const override {
    return Legalizer.get();
  }

  InstructionSelector *getInstructionSelector() const override {
    return InstSelector.get();
  }

  const SPIRVInstrInfo *getInstrInfo() const override { return &InstrInfo; }

  const SPIRVFrameLowering *getFrameLowering() const override {
    return &FrameLowering;
  }

  const SPIRVTargetLowering *getTargetLowering() const override {
    return &TLInfo;
  }

  const SPIRVRegisterInfo *getRegisterInfo() const override {
    return &InstrInfo.getRegisterInfo();
  }
};
} // namespace llvm

#endif // LLVM_LIB_TARGET_SPIRV_SPIRVSUBTARGET_H
