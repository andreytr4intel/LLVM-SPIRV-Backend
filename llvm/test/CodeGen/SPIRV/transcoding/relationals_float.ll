; RUN: llc -O0 %s -o - | FileCheck %s --check-prefix=CHECK-SPIRV

; This test checks following SYCL relational builtins with float and float2
; types:
;   isfinite, isinf, isnan, isnormal, signbit, isequal, isnotequal, isgreater
;   isgreaterequal, isless, islessequal, islessgreater, isordered, isunordered

; CHECK-SPIRV: %[[BoolTypeID:[0-9]+]] = OpTypeBool
; CHECK-SPIRV: %[[BoolVectorTypeID:[0-9]+]] = OpTypeVector %[[BoolTypeID]] 2

; CHECK-SPIRV: OpIsFinite %[[BoolTypeID]]
; CHECK-SPIRV: OpIsInf %[[BoolTypeID]]
; CHECK-SPIRV: OpIsNan %[[BoolTypeID]]
; CHECK-SPIRV: OpIsNormal %[[BoolTypeID]]
; CHECK-SPIRV: OpSignBitSet %[[BoolTypeID]]
; CHECK-SPIRV: OpFOrdEqual %[[BoolTypeID]]
; CHECK-SPIRV: OpFUnordNotEqual %[[BoolTypeID]]
; CHECK-SPIRV: OpFOrdGreaterThan %[[BoolTypeID]]
; CHECK-SPIRV: OpFOrdGreaterThanEqual %[[BoolTypeID]]
; CHECK-SPIRV: OpFOrdLessThan %[[BoolTypeID]]
; CHECK-SPIRV: OpFOrdLessThanEqual %[[BoolTypeID]]
; CHECK-SPIRV: OpFOrdNotEqual %[[BoolTypeID]]
; CHECK-SPIRV: OpOrdered %[[BoolTypeID]]
; CHECK-SPIRV: OpUnordered %[[BoolTypeID]]

; CHECK-SPIRV: OpIsFinite %[[BoolVectorTypeID]]
; CHECK-SPIRV: OpIsInf %[[BoolVectorTypeID]]
; CHECK-SPIRV: OpIsNan %[[BoolVectorTypeID]]
; CHECK-SPIRV: OpIsNormal %[[BoolVectorTypeID]]
; CHECK-SPIRV: OpSignBitSet %[[BoolVectorTypeID]]
; CHECK-SPIRV: OpFOrdEqual %[[BoolVectorTypeID]]
; CHECK-SPIRV: OpFUnordNotEqual %[[BoolVectorTypeID]]
; CHECK-SPIRV: OpFOrdGreaterThan %[[BoolVectorTypeID]]
; CHECK-SPIRV: OpFOrdGreaterThanEqual %[[BoolVectorTypeID]]
; CHECK-SPIRV: OpFOrdLessThan %[[BoolVectorTypeID]]
; CHECK-SPIRV: OpFOrdLessThanEqual %[[BoolVectorTypeID]]
; CHECK-SPIRV: OpFOrdNotEqual %[[BoolVectorTypeID]]
; CHECK-SPIRV: OpOrdered %[[BoolVectorTypeID]]
; CHECK-SPIRV: OpUnordered %[[BoolVectorTypeID]]

target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spirv32-unknown-unknown"

; Function Attrs: convergent mustprogress nofree norecurse nounwind willreturn writeonly
define dso_local spir_func void @test_scalar(i32 addrspace(4)* nocapture writeonly %out, float %f) local_unnamed_addr #0 {
entry:
  %call = tail call spir_func i32 @_Z8isfinitef(float %f) #3
  %call1 = tail call spir_func i32 @_Z5isinff(float %f) #3
  %add = add nsw i32 %call1, %call
  %call2 = tail call spir_func i32 @_Z5isnanf(float %f) #3
  %add3 = add nsw i32 %add, %call2
  %call4 = tail call spir_func i32 @_Z8isnormalf(float %f) #3
  %add5 = add nsw i32 %add3, %call4
  %call6 = tail call spir_func i32 @_Z7signbitf(float %f) #3
  %add7 = add nsw i32 %add5, %call6
  %call8 = tail call spir_func i32 @_Z7isequalff(float %f, float %f) #3
  %add9 = add nsw i32 %add7, %call8
  %call10 = tail call spir_func i32 @_Z10isnotequalff(float %f, float %f) #3
  %add11 = add nsw i32 %add9, %call10
  %call12 = tail call spir_func i32 @_Z9isgreaterff(float %f, float %f) #3
  %add13 = add nsw i32 %add11, %call12
  %call14 = tail call spir_func i32 @_Z14isgreaterequalff(float %f, float %f) #3
  %add15 = add nsw i32 %add13, %call14
  %call16 = tail call spir_func i32 @_Z6islessff(float %f, float %f) #3
  %add17 = add nsw i32 %add15, %call16
  %call18 = tail call spir_func i32 @_Z11islessequalff(float %f, float %f) #3
  %add19 = add nsw i32 %add17, %call18
  %call20 = tail call spir_func i32 @_Z13islessgreaterff(float %f, float %f) #3
  %add21 = add nsw i32 %add19, %call20
  %call22 = tail call spir_func i32 @_Z9isorderedff(float %f, float %f) #3
  %add23 = add nsw i32 %add21, %call22
  %call24 = tail call spir_func i32 @_Z11isunorderedff(float %f, float %f) #3
  %add25 = add nsw i32 %add23, %call24
  store i32 %add25, i32 addrspace(4)* %out, align 4, !tbaa !3
  ret void
}

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func i32 @_Z8isfinitef(float) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func i32 @_Z5isinff(float) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func i32 @_Z5isnanf(float) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func i32 @_Z8isnormalf(float) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func i32 @_Z7signbitf(float) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func i32 @_Z7isequalff(float, float) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func i32 @_Z10isnotequalff(float, float) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func i32 @_Z9isgreaterff(float, float) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func i32 @_Z14isgreaterequalff(float, float) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func i32 @_Z6islessff(float, float) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func i32 @_Z11islessequalff(float, float) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func i32 @_Z13islessgreaterff(float, float) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func i32 @_Z9isorderedff(float, float) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func i32 @_Z11isunorderedff(float, float) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree norecurse nounwind willreturn writeonly
define dso_local spir_func void @test_vector(<2 x i32> addrspace(4)* nocapture writeonly %out, <2 x float> %f) local_unnamed_addr #2 {
entry:
  %call = tail call spir_func <2 x i32> @_Z8isfiniteDv2_f(<2 x float> %f) #3
  %call1 = tail call spir_func <2 x i32> @_Z5isinfDv2_f(<2 x float> %f) #3
  %add = add <2 x i32> %call1, %call
  %call2 = tail call spir_func <2 x i32> @_Z5isnanDv2_f(<2 x float> %f) #3
  %add3 = add <2 x i32> %add, %call2
  %call4 = tail call spir_func <2 x i32> @_Z8isnormalDv2_f(<2 x float> %f) #3
  %add5 = add <2 x i32> %add3, %call4
  %call6 = tail call spir_func <2 x i32> @_Z7signbitDv2_f(<2 x float> %f) #3
  %add7 = add <2 x i32> %add5, %call6
  %call8 = tail call spir_func <2 x i32> @_Z7isequalDv2_fS_(<2 x float> %f, <2 x float> %f) #3
  %add9 = add <2 x i32> %add7, %call8
  %call10 = tail call spir_func <2 x i32> @_Z10isnotequalDv2_fS_(<2 x float> %f, <2 x float> %f) #3
  %add11 = add <2 x i32> %add9, %call10
  %call12 = tail call spir_func <2 x i32> @_Z9isgreaterDv2_fS_(<2 x float> %f, <2 x float> %f) #3
  %add13 = add <2 x i32> %add11, %call12
  %call14 = tail call spir_func <2 x i32> @_Z14isgreaterequalDv2_fS_(<2 x float> %f, <2 x float> %f) #3
  %add15 = add <2 x i32> %add13, %call14
  %call16 = tail call spir_func <2 x i32> @_Z6islessDv2_fS_(<2 x float> %f, <2 x float> %f) #3
  %add17 = add <2 x i32> %add15, %call16
  %call18 = tail call spir_func <2 x i32> @_Z11islessequalDv2_fS_(<2 x float> %f, <2 x float> %f) #3
  %add19 = add <2 x i32> %add17, %call18
  %call20 = tail call spir_func <2 x i32> @_Z13islessgreaterDv2_fS_(<2 x float> %f, <2 x float> %f) #3
  %add21 = add <2 x i32> %add19, %call20
  %call22 = tail call spir_func <2 x i32> @_Z9isorderedDv2_fS_(<2 x float> %f, <2 x float> %f) #3
  %add23 = add <2 x i32> %add21, %call22
  %call24 = tail call spir_func <2 x i32> @_Z11isunorderedDv2_fS_(<2 x float> %f, <2 x float> %f) #3
  %add25 = add <2 x i32> %add23, %call24
  store <2 x i32> %add25, <2 x i32> addrspace(4)* %out, align 8, !tbaa !7
  ret void
}

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func <2 x i32> @_Z8isfiniteDv2_f(<2 x float>) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func <2 x i32> @_Z5isinfDv2_f(<2 x float>) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func <2 x i32> @_Z5isnanDv2_f(<2 x float>) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func <2 x i32> @_Z8isnormalDv2_f(<2 x float>) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func <2 x i32> @_Z7signbitDv2_f(<2 x float>) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func <2 x i32> @_Z7isequalDv2_fS_(<2 x float>, <2 x float>) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func <2 x i32> @_Z10isnotequalDv2_fS_(<2 x float>, <2 x float>) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func <2 x i32> @_Z9isgreaterDv2_fS_(<2 x float>, <2 x float>) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func <2 x i32> @_Z14isgreaterequalDv2_fS_(<2 x float>, <2 x float>) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func <2 x i32> @_Z6islessDv2_fS_(<2 x float>, <2 x float>) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func <2 x i32> @_Z11islessequalDv2_fS_(<2 x float>, <2 x float>) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func <2 x i32> @_Z13islessgreaterDv2_fS_(<2 x float>, <2 x float>) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func <2 x i32> @_Z9isorderedDv2_fS_(<2 x float>, <2 x float>) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare spir_func <2 x i32> @_Z11isunorderedDv2_fS_(<2 x float>, <2 x float>) local_unnamed_addr #1

attributes #0 = { convergent mustprogress nofree norecurse nounwind willreturn writeonly "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { convergent mustprogress nofree nounwind readnone willreturn "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #2 = { convergent mustprogress nofree norecurse nounwind willreturn writeonly "frame-pointer"="none" "min-legal-vector-width"="64" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #3 = { convergent nounwind readnone willreturn }

!llvm.module.flags = !{!0}
!opencl.ocl.version = !{!1}
!opencl.spir.version = !{!1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 2, i32 0}
!2 = !{!"clang version 14.0.0"}
!3 = !{!4, !4, i64 0}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = !{!5, !5, i64 0}
