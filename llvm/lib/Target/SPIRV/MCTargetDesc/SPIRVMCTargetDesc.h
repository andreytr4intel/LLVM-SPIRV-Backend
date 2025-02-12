//===-- SPIRVMCTargetDesc.h - SPIR-V Target Descriptions --------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file provides SPIR-V specific target descriptions.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_SPIRV_MCTARGETDESC_SPIRVMCTARGETDESC_H
#define LLVM_LIB_TARGET_SPIRV_MCTARGETDESC_SPIRVMCTARGETDESC_H

#include "llvm/Support/DataTypes.h"
#include <memory>

namespace llvm {
class MCAsmBackend;
class MCCodeEmitter;
class MCContext;
class MCInstrInfo;
class MCObjectTargetWriter;
class MCRegisterInfo;
class MCSubtargetInfo;
class MCTargetOptions;
class Target;

MCCodeEmitter *createSPIRVMCCodeEmitter(const MCInstrInfo &MCII,
                                        const MCRegisterInfo &MRI,
                                        MCContext &Ctx);

MCAsmBackend *createSPIRVAsmBackend(const Target &T, const MCSubtargetInfo &STI,
                                    const MCRegisterInfo &MRI,
                                    const MCTargetOptions &Options);

std::unique_ptr<MCObjectTargetWriter> createSPIRVObjectTargetWriter();
} // namespace llvm

// Defines symbolic names for SPIR-V registers.  This defines a mapping from
// register name to register number.
#define GET_REGINFO_ENUM
#include "SPIRVGenRegisterInfo.inc"

// Defines symbolic names for the SPIR-V instructions.
#define GET_INSTRINFO_ENUM
#include "SPIRVGenInstrInfo.inc"

#define GET_SUBTARGETINFO_ENUM
#include "SPIRVGenSubtargetInfo.inc"

#endif // LLVM_LIB_TARGET_SPIRV_MCTARGETDESC_SPIRVMCTARGETDESC_H
