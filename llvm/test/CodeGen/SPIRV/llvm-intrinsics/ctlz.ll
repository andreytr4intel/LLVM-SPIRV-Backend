; RUN: llc -O0 %s -o - | FileCheck %s

target datalayout = "e-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spirv64-unknown-unknown"

; CHECK: %[[extinst_id:[0-9]+]] = OpExtInstImport "OpenCL.std"

; CHECK: OpFunction
; CHECK: %{{[0-9]+}} = OpExtInst %{{[0-9]+}} %[[extinst_id]] clz
; CHECK: OpFunctionEnd

; Function Attrs: nounwind readnone
define spir_func i32 @TestClz(i32 %x) local_unnamed_addr #0 {
entry:
  %0 = tail call i32 @llvm.ctlz.i32(i32 %x, i1 true)
  ret i32 %0
}

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.ctlz.i32(i32, i1 immarg) #1

attributes #0 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "denorms-are-zero"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.module.flags = !{!0}
!opencl.ocl.version = !{!1}
!opencl.spir.version = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, i32 0}
!2 = !{i32 1, i32 2}
