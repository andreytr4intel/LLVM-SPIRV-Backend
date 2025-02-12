; RUN: llc -O0 %s -o - | FileCheck %s --check-prefix=CHECK-SPIRV

; CHECK-SPIRV: %[[IMAGE_TYPE:[0-9]+]] = OpTypeImage
; CHECK-SPIRV: %[[IMAGE_ARG:[0-9]+]] = OpFunctionParameter %[[IMAGE_TYPE]]
; CHECK-SPIRV: %{{[0-9]+}} = OpImageQuerySizeLod %{{[0-9]+}} %[[IMAGE_ARG]]
; CHECK-SPIRV: %{{[0-9]+}} = OpImageQuerySizeLod %{{[0-9]+}} %[[IMAGE_ARG]]

; ModuleID = 'out.ll'
target datalayout = "e-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spirv64-unknown-unknown"

%opencl.image2d_array_ro_t = type opaque

; Function Attrs: nounwind
define spir_kernel void @sample_kernel(%opencl.image2d_array_ro_t addrspace(1)* %input) #0 !kernel_arg_addr_space !1 !kernel_arg_access_qual !2 !kernel_arg_type !3 !kernel_arg_base_type !5 !kernel_arg_type_qual !4 {
entry:
  %call.tmp1 = call spir_func <2 x i32> @_Z13get_image_dim20ocl_image2d_array_ro(%opencl.image2d_array_ro_t addrspace(1)* %input)
  %call.tmp2 = shufflevector <2 x i32> %call.tmp1, <2 x i32> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %call.tmp3 = call spir_func i64 @_Z20get_image_array_size20ocl_image2d_array_ro(%opencl.image2d_array_ro_t addrspace(1)* %input)
  %call.tmp4 = trunc i64 %call.tmp3 to i32
  %call.tmp5 = insertelement <3 x i32> %call.tmp2, i32 %call.tmp4, i32 2
  %call.old = extractelement <3 x i32> %call.tmp5, i32 0
  ret void
}

; Function Attrs: nounwind
declare spir_func <2 x i32> @_Z13get_image_dim20ocl_image2d_array_ro(%opencl.image2d_array_ro_t addrspace(1)*) #0

; Function Attrs: nounwind
declare spir_func i64 @_Z20get_image_array_size20ocl_image2d_array_ro(%opencl.image2d_array_ro_t addrspace(1)*) #0

attributes #0 = { nounwind }

!opencl.enable.FP_CONTRACT = !{}
!spirv.Source = !{!6}
!opencl.spir.version = !{!7}
!opencl.ocl.version = !{!7}
!opencl.used.extensions = !{!8}
!opencl.used.optional.core.features = !{!9}
!spirv.Generator = !{!10}

!1 = !{i32 1}
!2 = !{!"read_only"}
!3 = !{!"image2d_array_t"}
!4 = !{!""}
!5 = !{!"image2d_array_t"}
!6 = !{i32 3, i32 102000}
!7 = !{i32 1, i32 2}
!8 = !{}
!9 = !{!"cl_images"}
!10 = !{i16 6, i16 14}
