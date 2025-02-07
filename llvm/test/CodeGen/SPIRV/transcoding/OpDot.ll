; RUN: llc -O0 %s -o - | FileCheck %s --check-prefix=CHECK-SPIRV

target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spirv32-unknown-unknown"

; The OpDot operands must be vectors; check that translating dot with
; scalar arguments does not result in OpDot.
; CHECK-SPIRV-LABEL:	%{{[0-9]+}} = OpFunction %{{[0-9]+}} None %{{[0-9]+}}
; CHECK-SPIRV:	%{{[0-9]+}} = OpFMul %{{[0-9]+}} %{{[0-9]+}} %{{[0-9]+}}
; CHECK-SPIRV-NOT: %{{[0-9]+}} = OpDot %{{[0-9]+}} %{{[0-9]+}} %{{[0-9]+}}
; CHECK-SPIRV:	OpFunctionEnd

; Function Attrs: nounwind
define spir_kernel void @testScalar(float %f) #0 !kernel_arg_addr_space !1 !kernel_arg_access_qual !2 !kernel_arg_type !3 !kernel_arg_base_type !4 !kernel_arg_type_qual !5 {
entry:
  %call = tail call spir_func float @_Z3dotff(float %f, float %f) #2
  ret void
}

; The OpDot operands must be vectors; check that translating dot with
; vector arguments results in OpDot.
; CHECK-SPIRV-LABEL:	%{{[0-9]+}} = OpFunction %{{[0-9]+}} None %{{[0-9]+}}
; CHECK-SPIRV: %{{[0-9]+}} = OpDot %{{[0-9]+}} %{{[0-9]+}} %{{[0-9]+}}
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: nounwind
define spir_kernel void @testVector(<2 x float> %f) #0 !kernel_arg_addr_space !1 !kernel_arg_access_qual !2 !kernel_arg_type !3 !kernel_arg_base_type !4 !kernel_arg_type_qual !5 {
entry:
  %call = tail call spir_func float @_Z3dotDv2_fS_(<2 x float> %f, <2 x float> %f) #2
  ret void
}

declare spir_func float @_Z3dotff(float, float) #1

declare spir_func float @_Z3dotDv2_fS_(<2 x float>, <2 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.enable.FP_CONTRACT = !{}
!opencl.spir.version = !{!6}
!opencl.ocl.version = !{!7}
!opencl.used.extensions = !{!8}
!opencl.used.optional.core.features = !{!8}
!opencl.compiler.options = !{!8}

!1 = !{i32 0}
!2 = !{!"none"}
!3 = !{!"float"}
!4 = !{!"float"}
!5 = !{!""}
!6 = !{i32 1, i32 2}
!7 = !{i32 2, i32 0}
!8 = !{}
