; RUN: llc -O0 %s -o - | FileCheck %s

target datalayout = "e-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spirv64-unknown-unknown"

; CHECK: %[[extinst_id:[0-9]+]] = OpExtInstImport "OpenCL.std"

; CHECK: %[[var0:[0-9]+]] = OpTypeFloat 16
; CHECK: %[[var1:[0-9]+]] = OpTypeFloat 32
; CHECK: %[[var2:[0-9]+]] = OpTypeFloat 64
; CHECK: %[[var3:[0-9]+]] = OpTypeVector %[[var1]] 4

; CHECK: OpFunction
; CHECK: %{{[0-9]+}} = OpExtInst %[[var0]] %[[extinst_id]] fabs
; CHECK: OpFunctionEnd

; Function Attrs: nounwind readnone
define spir_func half @TestFabs16(half %x) local_unnamed_addr #0 {
entry:
  %0 = tail call half @llvm.fabs.f16(half %x)
  ret half %0
}

; CHECK: OpFunction
; CHECK: %{{[0-9]+}} = OpExtInst %[[var1]] %[[extinst_id]] fabs
; CHECK: OpFunctionEnd

; Function Attrs: nounwind readnone
define spir_func float @TestFabs32(float %x) local_unnamed_addr #0 {
entry:
  %0 = tail call float @llvm.fabs.f32(float %x)
  ret float %0
}

; CHECK: OpFunction
; CHECK: %{{[0-9]+}} = OpExtInst %[[var2]] %[[extinst_id]] fabs
; CHECK: OpFunctionEnd

; Function Attrs: nounwind readnone
define spir_func double @TestFabs64(double %x) local_unnamed_addr #0 {
entry:
  %0 = tail call double @llvm.fabs.f64(double %x)
  ret double %0
}

; CHECK: OpFunction
; CHECK: %{{[0-9]+}} = OpExtInst %[[var3]] %[[extinst_id]] fabs
; CHECK: OpFunctionEnd

; Function Attrs: nounwind readnone
define spir_func <4 x float> @TestFabsVec(<4 x float> %x) local_unnamed_addr #0 {
entry:
  %0 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %x)
  ret <4 x float> %0
}

; Function Attrs: nounwind readnone
declare half @llvm.fabs.f16(half) #1

; Function Attrs: nounwind readnone
declare float @llvm.fabs.f32(float) #1

; Function Attrs: nounwind readnone
declare double @llvm.fabs.f64(double) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fabs.v4f32(<4 x float>) #1

attributes #0 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "denorms-are-zero"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.module.flags = !{!0}
!opencl.ocl.version = !{!1}
!opencl.spir.version = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, i32 0}
!2 = !{i32 1, i32 2}
