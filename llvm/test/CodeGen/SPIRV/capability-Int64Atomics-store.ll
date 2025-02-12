; OpenCL C source:
; #pragma OPENCL EXTENSION cl_khr_int64_base_atomics : enable
; #pragma OPENCL EXTENSION cl_khr_int64_extended_atomics : enable
;
; void foo (volatile atomic_long *object, long desired) {
;   atomic_store(object, desired);
;}

; RUN: llc -O0 %s -o - | FileCheck %s

; CHECK: OpCapability Int64Atomics

target datalayout = "e-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-n8:16:32:64"
target triple = "spirv64-unknown-unknown"

; Function Attrs: nounwind
define spir_func void @foo(i64 addrspace(4)* %object, i64 %desired) #0 {
entry:
  tail call spir_func void @_Z12atomic_storePVU3AS4U7_Atomicll(i64 addrspace(4)* %object, i64 %desired) #2
  ret void
}

declare spir_func void @_Z12atomic_storePVU3AS4U7_Atomicll(i64 addrspace(4)*, i64) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.enable.FP_CONTRACT = !{}
!opencl.spir.version = !{!0}
!opencl.ocl.version = !{!1}
!opencl.used.extensions = !{!2}
!opencl.used.optional.core.features = !{!2}
!opencl.compiler.options = !{!2}

!0 = !{i32 1, i32 2}
!1 = !{i32 2, i32 0}
!2 = !{}
