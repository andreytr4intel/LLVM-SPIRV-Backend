; RUN: llc -O0 %s -o - | FileCheck %s

target datalayout = "e-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spirv64-unknown-unknown"

; Function Attrs: nounwind readnone
define spir_func i32 @Test(i32 %x) local_unnamed_addr #0 {
entry:
  %0 = call i32 @llvm.usub.sat.i32(i32 3, i32 %x)
  ret i32 %0
}

; CHECK: %[[three:[0-9]+]] = OpConstant %{{[0-9]+}} 3
; CHECK: %[[zero:[0-9]+]] = OpConstant %{{[0-9]+}} 0

; CHECK: OpFunction
; CHECK: %[[x:[0-9]+]] = OpFunctionParameter %{{[0-9]+}}
; CHECK: %[[sub_res:[0-9]+]] = OpISub %{{[0-9]+}} %[[three]] %[[x]]
; CHECK: %[[cmp_res:[0-9]+]] = OpUGreaterThan %{{[0-9]+}} %[[three]] %[[x]]
; CHECK: %[[sel_res:[0-9]+]] = OpSelect %{{[0-9]+}} %[[cmp_res]] %[[sub_res]] %[[zero]]
; CHECK: OpReturnValue %[[sel_res]]

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.usub.sat.i32(i32, i32) #1

attributes #0 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "denorms-are-zero"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.module.flags = !{!0}
!opencl.ocl.version = !{!1}
!opencl.spir.version = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, i32 0}
!2 = !{i32 1, i32 2}
