; RUN: llc -O0 %s -o - | FileCheck %s

; ModuleID = '../rel/CheckCapKernelWithoutKernel.bc'
target datalayout = "e-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-n8:16:32:64"
target triple = "spirv64-unknown-unknown"

@a = addrspace(2) constant i32 1, align 4

; CHECK-DAG: OpCapability Kernel

!opencl.enable.FP_CONTRACT = !{}
!opencl.spir.version = !{!0}
!opencl.ocl.version = !{!1}
!opencl.used.extensions = !{!2}
!opencl.used.optional.core.features = !{!2}
!opencl.compiler.options = !{!2}
!llvm.ident = !{!3}

!0 = !{i32 1, i32 2}
!1 = !{i32 1, i32 0}
!2 = !{}
!3 = !{!"clang version 3.6.1 "}
