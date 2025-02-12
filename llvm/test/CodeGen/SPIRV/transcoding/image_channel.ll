; RUN: llc -O0 %s -o - | FileCheck %s --check-prefix=CHECK-SPIRV

target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spirv32-unknown-unknown"

%opencl.image2d_ro_t = type opaque
; CHECK-SPIRV-DAG: %[[DataTypeOffsetId:[0-9]+]] = OpConstant %{{[0-9]+}} 4304
; CHECK-SPIRV-DAG: %[[OrderOffsetId:[0-9]+]] = OpConstant %{{[0-9]+}} 4272

; Function Attrs: nounwind
define spir_kernel void @f(%opencl.image2d_ro_t addrspace(1)* %img, i32 addrspace(1)* nocapture %type, i32 addrspace(1)* nocapture %order) #0 !kernel_arg_addr_space !1 !kernel_arg_access_qual !2 !kernel_arg_type !3 !kernel_arg_base_type !4 !kernel_arg_type_qual !5 {
; CHECK-SPIRV: %[[DataTypeID:[0-9]+]] = OpImageQueryFormat %{{[0-9]+}}
; CHECK-SPIRV: %[[DTAddID:[0-9]+]] = OpIAdd %{{[0-9]+}} %[[DataTypeID]] %[[DataTypeOffsetId]]
; CHECK-SPIRV: OpStore %{{[0-9]+}} %[[DTAddID]]

  %1 = tail call spir_func i32 @_Z27get_image_channel_data_type14ocl_image2d_ro(%opencl.image2d_ro_t addrspace(1)* %img) #2
  store i32 %1, i32 addrspace(1)* %type, align 4

; CHECK-SPIRV: %[[OrderID:[0-9]+]] = OpImageQueryOrder %{{[0-9]+}}
; CHECK-SPIRV: %[[OrderAddID:[0-9]+]] = OpIAdd %{{[0-9]+}} %[[OrderID]] %[[OrderOffsetId]]
; CHECK-SPIRV: OpStore %{{[0-9]+}} %[[OrderAddID]]

  %2 = tail call spir_func i32 @_Z23get_image_channel_order14ocl_image2d_ro(%opencl.image2d_ro_t addrspace(1)* %img) #2
  store i32 %2, i32 addrspace(1)* %order, align 4
  ret void
}

declare spir_func i32 @_Z27get_image_channel_data_type14ocl_image2d_ro(%opencl.image2d_ro_t addrspace(1)*) #1

declare spir_func i32 @_Z23get_image_channel_order14ocl_image2d_ro(%opencl.image2d_ro_t addrspace(1)*) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.spir.version = !{!6}
!opencl.ocl.version = !{!7}
!opencl.used.extensions = !{!8}
!opencl.used.optional.core.features = !{!9}
!opencl.compiler.options = !{!8}

!1 = !{i32 1, i32 1, i32 1}
!2 = !{!"read_only", !"none", !"none"}
!3 = !{!"image2d_t", !"int*", !"int*"}
!4 = !{!"image2d_t", !"int*", !"int*"}
!5 = !{!"", !"", !""}
!6 = !{i32 1, i32 2}
!7 = !{i32 2, i32 0}
!8 = !{}
!9 = !{!"cl_images"}
