; RUN: llc -O0 %s -o - | FileCheck %s

target triple = "spirv32-unknown-unknown"

; FIXME: ensure Magic Number, version number, generator's magic number, "bound" and "schema" are at least present

; Ensure the required Capabilities are listed.
; CHECK-DAG: OpCapability Kernel
; CHECK-DAG: OpCapability Addresses

; Ensure one, and only one, OpMemoryModel is defined.
; CHECK: OpMemoryModel Physical32 OpenCL
; CHECK-NOT: OpMemoryModel
