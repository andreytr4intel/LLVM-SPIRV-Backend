; Source:
;
; typedef int myInt;
;
; typedef struct {
;   int width;
;   int height;
; } image_kernel_data;
;
; struct struct_name {
;   int i;
;   int y;
; };
; void kernel foo(__global image_kernel_data* in,
;                 __global struct struct_name *outData,
;                 myInt out) {}

; In LLVM -> SPIRV translation original names of types (typedefs) are missed,
; there is no defined possibility to keep a typedef name by SPIR-V spec.
; As a workaround we store original names in OpString instruction:
; OpString "kernel_arg_type.%kernel_name%.typename0,typename1,..."

; RUN: llc -O0 %s -o - | FileCheck %s --check-prefix=CHECK-SPIRV

target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spirv32-unknown-unknown"

; CHECK-SPIRV: OpString "kernel_arg_type.foo.image_kernel_data*,myInt,struct struct_name*,"

%struct.image_kernel_data = type { i32, i32, i32, i32, i32 }
%struct.struct_name = type { i32, i32 }

; Function Attrs: convergent noinline nounwind optnone
define spir_kernel void @foo(%struct.image_kernel_data addrspace(1)* %in, i32 %out, %struct.struct_name addrspace(1)* %outData) #0 !kernel_arg_addr_space !5 !kernel_arg_access_qual !6 !kernel_arg_type !7 !kernel_arg_base_type !8 !kernel_arg_type_qual !9 {
entry:
  ret void
}

attributes #0 = { convergent noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!1}
!opencl.spir.version = !{!2}
!opencl.used.extensions = !{!3}
!opencl.used.optional.core.features = !{!3}
!opencl.compiler.options = !{!3}
!llvm.ident = !{!4}
!opencl.kernels = !{!10}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, i32 0}
!2 = !{i32 1, i32 2}
!3 = !{}
!4 = !{!"clang version 6.0.0"}
!5 = !{i32 1, i32 0, i32 1}
!6 = !{!"none", !"none", !"none"}
!7 = !{!"image_kernel_data*", !"myInt", !"struct struct_name*"}
!8 = !{!"image_kernel_data*", !"int", !"struct struct_name*"}
!9 = !{!"", !"", !""}
!10 = !{void (%struct.image_kernel_data addrspace(1)*, i32, %struct.struct_name addrspace(1)*)* @foo}
