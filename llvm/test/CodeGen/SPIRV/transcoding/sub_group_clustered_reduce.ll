;; #pragma OPENCL EXTENSION cl_khr_subgroup_clustered_reduce : enable
;; #pragma OPENCL EXTENSION cl_khr_fp16 : enable
;; #pragma OPENCL EXTENSION cl_khr_fp64 : enable
;; 
;; kernel void testClusteredArithmeticChar(global char* dst)
;; {
;;     char v = 0;
;;     dst[0] = sub_group_clustered_reduce_add(v, 2);
;;     dst[1] = sub_group_clustered_reduce_mul(v, 2);
;;     dst[2] = sub_group_clustered_reduce_min(v, 2);
;;     dst[3] = sub_group_clustered_reduce_max(v, 2);
;; }
;; 
;; kernel void testClusteredArithmeticUChar(global uchar* dst)
;; {
;;     uchar v = 0;
;;     dst[0] = sub_group_clustered_reduce_add(v, 2);
;;     dst[1] = sub_group_clustered_reduce_mul(v, 2);
;;     dst[2] = sub_group_clustered_reduce_min(v, 2);
;;     dst[3] = sub_group_clustered_reduce_max(v, 2);
;; }
;; 
;; kernel void testClusteredArithmeticShort(global short* dst)
;; {
;;     short v = 0;
;;     dst[0] = sub_group_clustered_reduce_add(v, 2);
;;     dst[1] = sub_group_clustered_reduce_mul(v, 2);
;;     dst[2] = sub_group_clustered_reduce_min(v, 2);
;;     dst[3] = sub_group_clustered_reduce_max(v, 2);
;; }
;; 
;; kernel void testClusteredArithmeticUShort(global ushort* dst)
;; {
;;     ushort v = 0;
;;     dst[0] = sub_group_clustered_reduce_add(v, 2);
;;     dst[1] = sub_group_clustered_reduce_mul(v, 2);
;;     dst[2] = sub_group_clustered_reduce_min(v, 2);
;;     dst[3] = sub_group_clustered_reduce_max(v, 2);
;; }
;; 
;; kernel void testClusteredArithmeticInt(global int* dst)
;; {
;;     int v = 0;
;;     dst[0] = sub_group_clustered_reduce_add(v, 2);
;;     dst[1] = sub_group_clustered_reduce_mul(v, 2);
;;     dst[2] = sub_group_clustered_reduce_min(v, 2);
;;     dst[3] = sub_group_clustered_reduce_max(v, 2);
;; }
;; 
;; kernel void testClusteredArithmeticUInt(global uint* dst)
;; {
;;     uint v = 0;
;;     dst[0] = sub_group_clustered_reduce_add(v, 2);
;;     dst[1] = sub_group_clustered_reduce_mul(v, 2);
;;     dst[2] = sub_group_clustered_reduce_min(v, 2);
;;     dst[3] = sub_group_clustered_reduce_max(v, 2);
;; }
;; 
;; kernel void testClusteredArithmeticLong(global long* dst)
;; {
;;     long v = 0;
;;     dst[0] = sub_group_clustered_reduce_add(v, 2);
;;     dst[1] = sub_group_clustered_reduce_mul(v, 2);
;;     dst[2] = sub_group_clustered_reduce_min(v, 2);
;;     dst[3] = sub_group_clustered_reduce_max(v, 2);
;; }
;; 
;; kernel void testClusteredArithmeticULong(global ulong* dst)
;; {
;;     ulong v = 0;
;;     dst[0] = sub_group_clustered_reduce_add(v, 2);
;;     dst[1] = sub_group_clustered_reduce_mul(v, 2);
;;     dst[2] = sub_group_clustered_reduce_min(v, 2);
;;     dst[3] = sub_group_clustered_reduce_max(v, 2);
;; }
;; 
;; kernel void testClusteredArithmeticFloat(global float* dst)
;; {
;;     float v = 0;
;;     dst[0] = sub_group_clustered_reduce_add(v, 2);
;;     dst[1] = sub_group_clustered_reduce_mul(v, 2);
;;     dst[2] = sub_group_clustered_reduce_min(v, 2);
;;     dst[3] = sub_group_clustered_reduce_max(v, 2);
;; }
;; 
;; kernel void testClusteredArithmeticHalf(global half* dst)
;; {
;;     half v = 0;
;;     dst[0] = sub_group_clustered_reduce_add(v, 2);
;;     dst[1] = sub_group_clustered_reduce_mul(v, 2);
;;     dst[2] = sub_group_clustered_reduce_min(v, 2);
;;     dst[3] = sub_group_clustered_reduce_max(v, 2);
;; }
;; 
;; kernel void testClusteredArithmeticDouble(global double* dst)
;; {
;;     double v = 0;
;;     dst[0] = sub_group_clustered_reduce_add(v, 2);
;;     dst[1] = sub_group_clustered_reduce_mul(v, 2);
;;     dst[2] = sub_group_clustered_reduce_min(v, 2);
;;     dst[3] = sub_group_clustered_reduce_max(v, 2);
;; }
;; 
;; kernel void testClusteredBitwiseChar(global char* dst)
;; {
;;     char v = 0;
;;     dst[0] = sub_group_clustered_reduce_and(v, 2);
;;     dst[1] = sub_group_clustered_reduce_or(v, 2);
;;     dst[2] = sub_group_clustered_reduce_xor(v, 2);
;; }
;; 
;; kernel void testClusteredBitwiseUChar(global uchar* dst)
;; {
;;     uchar v = 0;
;;     dst[0] = sub_group_clustered_reduce_and(v, 2);
;;     dst[1] = sub_group_clustered_reduce_or(v, 2);
;;     dst[2] = sub_group_clustered_reduce_xor(v, 2);
;; }
;; 
;; kernel void testClusteredBitwiseShort(global short* dst)
;; {
;;     short v = 0;
;;     dst[0] = sub_group_clustered_reduce_and(v, 2);
;;     dst[1] = sub_group_clustered_reduce_or(v, 2);
;;     dst[2] = sub_group_clustered_reduce_xor(v, 2);
;; }
;; 
;; kernel void testClusteredBitwiseUShort(global ushort* dst)
;; {
;;     ushort v = 0;
;;     dst[0] = sub_group_clustered_reduce_and(v, 2);
;;     dst[1] = sub_group_clustered_reduce_or(v, 2);
;;     dst[2] = sub_group_clustered_reduce_xor(v, 2);
;; }
;; 
;; kernel void testClusteredBitwiseInt(global int* dst)
;; {
;;     int v = 0;
;;     dst[0] = sub_group_clustered_reduce_and(v, 2);
;;     dst[1] = sub_group_clustered_reduce_or(v, 2);
;;     dst[2] = sub_group_clustered_reduce_xor(v, 2);
;; }
;; 
;; kernel void testClusteredBitwiseUInt(global uint* dst)
;; {
;;     uint v = 0;
;;     dst[0] = sub_group_clustered_reduce_and(v, 2);
;;     dst[1] = sub_group_clustered_reduce_or(v, 2);
;;     dst[2] = sub_group_clustered_reduce_xor(v, 2);
;; }
;; 
;; kernel void testClusteredBitwiseLong(global long* dst)
;; {
;;     long v = 0;
;;     dst[0] = sub_group_clustered_reduce_and(v, 2);
;;     dst[1] = sub_group_clustered_reduce_or(v, 2);
;;     dst[2] = sub_group_clustered_reduce_xor(v, 2);
;; }
;; 
;; kernel void testClusteredBitwiseULong(global ulong* dst)
;; {
;;     ulong v = 0;
;;     dst[0] = sub_group_clustered_reduce_and(v, 2);
;;     dst[1] = sub_group_clustered_reduce_or(v, 2);
;;     dst[2] = sub_group_clustered_reduce_xor(v, 2);
;; }
;; 
;; kernel void testClusteredLogical(global int* dst)
;; {
;;     int v = 0;
;;     dst[0] = sub_group_clustered_reduce_logical_and(v, 2);
;;     dst[1] = sub_group_clustered_reduce_logical_or(v, 2);
;;     dst[2] = sub_group_clustered_reduce_logical_xor(v, 2);
;; }

; RUN: llc -O0 %s -o - | FileCheck %s --check-prefix=CHECK-SPIRV

; CHECK-SPIRV-DAG: OpCapability GroupNonUniformClustered

; CHECK-SPIRV-DAG: %[[bool:[0-9]+]] = OpTypeBool
; CHECK-SPIRV-DAG: %[[char:[0-9]+]] = OpTypeInt 8 0
; CHECK-SPIRV-DAG: %[[short:[0-9]+]] = OpTypeInt 16 0
; CHECK-SPIRV-DAG: %[[int:[0-9]+]] = OpTypeInt 32 0
; CHECK-SPIRV-DAG: %[[long:[0-9]+]] = OpTypeInt 64 0
; CHECK-SPIRV-DAG: %[[half:[0-9]+]] = OpTypeFloat 16
; CHECK-SPIRV-DAG: %[[float:[0-9]+]] = OpTypeFloat 32
; CHECK-SPIRV-DAG: %[[double:[0-9]+]] = OpTypeFloat 64

; CHECK-SPIRV-DAG: %[[false:[0-9]+]] = OpConstantFalse %[[bool]]
; CHECK-SPIRV-DAG: %[[ScopeSubgroup:[0-9]+]] = OpConstant %[[int]] 3
; CHECK-SPIRV-DAG: %[[char_0:[0-9]+]] = OpConstant %[[char]] 0
; CHECK-SPIRV-DAG: %[[short_0:[0-9]+]] = OpConstant %[[short]] 0
; CHECK-SPIRV-DAG: %[[int_0:[0-9]+]] = OpConstant %[[int]] 0
; CHECK-SPIRV-DAG: %[[int_2:[0-9]+]] = OpConstant %[[int]] 2
; CHECK-SPIRV-DAG: %[[long_0:[0-9]+]] = OpConstant %[[long]] 0 0
; CHECK-SPIRV-DAG: %[[half_0:[0-9]+]] = OpConstant %[[half]] 0
; CHECK-SPIRV-DAG: %[[float_0:[0-9]+]] = OpConstant %[[float]] 0
; CHECK-SPIRV-DAG: %[[double_0:[0-9]+]] = OpConstant %[[double]] 0

; ModuleID = 'sub_group_clustered_reduce.cl'
source_filename = "sub_group_clustered_reduce.cl"
target datalayout = "e-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spirv64-unknown-unknown"

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformIAdd %[[char]] %[[ScopeSubgroup]] ClusteredReduce %[[char_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformIMul %[[char]] %[[ScopeSubgroup]] ClusteredReduce %[[char_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformSMin %[[char]] %[[ScopeSubgroup]] ClusteredReduce %[[char_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformSMax %[[char]] %[[ScopeSubgroup]] ClusteredReduce %[[char_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredArithmeticChar(i8 addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !5 !kernel_arg_base_type !5 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func signext i8 @_Z30sub_group_clustered_reduce_addcj(i8 signext 0, i32 2) #2
  store i8 %2, i8 addrspace(1)* %0, align 1, !tbaa !7
  %3 = tail call spir_func signext i8 @_Z30sub_group_clustered_reduce_mulcj(i8 signext 0, i32 2) #2
  %4 = getelementptr inbounds i8, i8 addrspace(1)* %0, i64 1
  store i8 %3, i8 addrspace(1)* %4, align 1, !tbaa !7
  %5 = tail call spir_func signext i8 @_Z30sub_group_clustered_reduce_mincj(i8 signext 0, i32 2) #2
  %6 = getelementptr inbounds i8, i8 addrspace(1)* %0, i64 2
  store i8 %5, i8 addrspace(1)* %6, align 1, !tbaa !7
  %7 = tail call spir_func signext i8 @_Z30sub_group_clustered_reduce_maxcj(i8 signext 0, i32 2) #2
  %8 = getelementptr inbounds i8, i8 addrspace(1)* %0, i64 3
  store i8 %7, i8 addrspace(1)* %8, align 1, !tbaa !7
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func signext i8 @_Z30sub_group_clustered_reduce_addcj(i8 signext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func signext i8 @_Z30sub_group_clustered_reduce_mulcj(i8 signext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func signext i8 @_Z30sub_group_clustered_reduce_mincj(i8 signext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func signext i8 @_Z30sub_group_clustered_reduce_maxcj(i8 signext, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformIAdd %[[char]] %[[ScopeSubgroup]] ClusteredReduce %[[char_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformIMul %[[char]] %[[ScopeSubgroup]] ClusteredReduce %[[char_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformUMin %[[char]] %[[ScopeSubgroup]] ClusteredReduce %[[char_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformUMax %[[char]] %[[ScopeSubgroup]] ClusteredReduce %[[char_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredArithmeticUChar(i8 addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !10 !kernel_arg_base_type !10 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func zeroext i8 @_Z30sub_group_clustered_reduce_addhj(i8 zeroext 0, i32 2) #2
  store i8 %2, i8 addrspace(1)* %0, align 1, !tbaa !7
  %3 = tail call spir_func zeroext i8 @_Z30sub_group_clustered_reduce_mulhj(i8 zeroext 0, i32 2) #2
  %4 = getelementptr inbounds i8, i8 addrspace(1)* %0, i64 1
  store i8 %3, i8 addrspace(1)* %4, align 1, !tbaa !7
  %5 = tail call spir_func zeroext i8 @_Z30sub_group_clustered_reduce_minhj(i8 zeroext 0, i32 2) #2
  %6 = getelementptr inbounds i8, i8 addrspace(1)* %0, i64 2
  store i8 %5, i8 addrspace(1)* %6, align 1, !tbaa !7
  %7 = tail call spir_func zeroext i8 @_Z30sub_group_clustered_reduce_maxhj(i8 zeroext 0, i32 2) #2
  %8 = getelementptr inbounds i8, i8 addrspace(1)* %0, i64 3
  store i8 %7, i8 addrspace(1)* %8, align 1, !tbaa !7
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func zeroext i8 @_Z30sub_group_clustered_reduce_addhj(i8 zeroext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func zeroext i8 @_Z30sub_group_clustered_reduce_mulhj(i8 zeroext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func zeroext i8 @_Z30sub_group_clustered_reduce_minhj(i8 zeroext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func zeroext i8 @_Z30sub_group_clustered_reduce_maxhj(i8 zeroext, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformIAdd %[[short]] %[[ScopeSubgroup]] ClusteredReduce %[[short_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformIMul %[[short]] %[[ScopeSubgroup]] ClusteredReduce %[[short_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformSMin %[[short]] %[[ScopeSubgroup]] ClusteredReduce %[[short_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformSMax %[[short]] %[[ScopeSubgroup]] ClusteredReduce %[[short_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredArithmeticShort(i16 addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !11 !kernel_arg_base_type !11 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func signext i16 @_Z30sub_group_clustered_reduce_addsj(i16 signext 0, i32 2) #2
  store i16 %2, i16 addrspace(1)* %0, align 2, !tbaa !12
  %3 = tail call spir_func signext i16 @_Z30sub_group_clustered_reduce_mulsj(i16 signext 0, i32 2) #2
  %4 = getelementptr inbounds i16, i16 addrspace(1)* %0, i64 1
  store i16 %3, i16 addrspace(1)* %4, align 2, !tbaa !12
  %5 = tail call spir_func signext i16 @_Z30sub_group_clustered_reduce_minsj(i16 signext 0, i32 2) #2
  %6 = getelementptr inbounds i16, i16 addrspace(1)* %0, i64 2
  store i16 %5, i16 addrspace(1)* %6, align 2, !tbaa !12
  %7 = tail call spir_func signext i16 @_Z30sub_group_clustered_reduce_maxsj(i16 signext 0, i32 2) #2
  %8 = getelementptr inbounds i16, i16 addrspace(1)* %0, i64 3
  store i16 %7, i16 addrspace(1)* %8, align 2, !tbaa !12
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func signext i16 @_Z30sub_group_clustered_reduce_addsj(i16 signext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func signext i16 @_Z30sub_group_clustered_reduce_mulsj(i16 signext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func signext i16 @_Z30sub_group_clustered_reduce_minsj(i16 signext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func signext i16 @_Z30sub_group_clustered_reduce_maxsj(i16 signext, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformIAdd %[[short]] %[[ScopeSubgroup]] ClusteredReduce %[[short_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformIMul %[[short]] %[[ScopeSubgroup]] ClusteredReduce %[[short_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformUMin %[[short]] %[[ScopeSubgroup]] ClusteredReduce %[[short_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformUMax %[[short]] %[[ScopeSubgroup]] ClusteredReduce %[[short_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredArithmeticUShort(i16 addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !14 !kernel_arg_base_type !14 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func zeroext i16 @_Z30sub_group_clustered_reduce_addtj(i16 zeroext 0, i32 2) #2
  store i16 %2, i16 addrspace(1)* %0, align 2, !tbaa !12
  %3 = tail call spir_func zeroext i16 @_Z30sub_group_clustered_reduce_multj(i16 zeroext 0, i32 2) #2
  %4 = getelementptr inbounds i16, i16 addrspace(1)* %0, i64 1
  store i16 %3, i16 addrspace(1)* %4, align 2, !tbaa !12
  %5 = tail call spir_func zeroext i16 @_Z30sub_group_clustered_reduce_mintj(i16 zeroext 0, i32 2) #2
  %6 = getelementptr inbounds i16, i16 addrspace(1)* %0, i64 2
  store i16 %5, i16 addrspace(1)* %6, align 2, !tbaa !12
  %7 = tail call spir_func zeroext i16 @_Z30sub_group_clustered_reduce_maxtj(i16 zeroext 0, i32 2) #2
  %8 = getelementptr inbounds i16, i16 addrspace(1)* %0, i64 3
  store i16 %7, i16 addrspace(1)* %8, align 2, !tbaa !12
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func zeroext i16 @_Z30sub_group_clustered_reduce_addtj(i16 zeroext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func zeroext i16 @_Z30sub_group_clustered_reduce_multj(i16 zeroext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func zeroext i16 @_Z30sub_group_clustered_reduce_mintj(i16 zeroext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func zeroext i16 @_Z30sub_group_clustered_reduce_maxtj(i16 zeroext, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformIAdd %[[int]] %[[ScopeSubgroup]] ClusteredReduce %[[int_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformIMul %[[int]] %[[ScopeSubgroup]] ClusteredReduce %[[int_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformSMin %[[int]] %[[ScopeSubgroup]] ClusteredReduce %[[int_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformSMax %[[int]] %[[ScopeSubgroup]] ClusteredReduce %[[int_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredArithmeticInt(i32 addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !15 !kernel_arg_base_type !15 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func i32 @_Z30sub_group_clustered_reduce_addij(i32 0, i32 2) #2
  store i32 %2, i32 addrspace(1)* %0, align 4, !tbaa !16
  %3 = tail call spir_func i32 @_Z30sub_group_clustered_reduce_mulij(i32 0, i32 2) #2
  %4 = getelementptr inbounds i32, i32 addrspace(1)* %0, i64 1
  store i32 %3, i32 addrspace(1)* %4, align 4, !tbaa !16
  %5 = tail call spir_func i32 @_Z30sub_group_clustered_reduce_minij(i32 0, i32 2) #2
  %6 = getelementptr inbounds i32, i32 addrspace(1)* %0, i64 2
  store i32 %5, i32 addrspace(1)* %6, align 4, !tbaa !16
  %7 = tail call spir_func i32 @_Z30sub_group_clustered_reduce_maxij(i32 0, i32 2) #2
  %8 = getelementptr inbounds i32, i32 addrspace(1)* %0, i64 3
  store i32 %7, i32 addrspace(1)* %8, align 4, !tbaa !16
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func i32 @_Z30sub_group_clustered_reduce_addij(i32, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i32 @_Z30sub_group_clustered_reduce_mulij(i32, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i32 @_Z30sub_group_clustered_reduce_minij(i32, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i32 @_Z30sub_group_clustered_reduce_maxij(i32, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformIAdd %[[int]] %[[ScopeSubgroup]] ClusteredReduce %[[int_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformIMul %[[int]] %[[ScopeSubgroup]] ClusteredReduce %[[int_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformUMin %[[int]] %[[ScopeSubgroup]] ClusteredReduce %[[int_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformUMax %[[int]] %[[ScopeSubgroup]] ClusteredReduce %[[int_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredArithmeticUInt(i32 addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !18 !kernel_arg_base_type !18 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func i32 @_Z30sub_group_clustered_reduce_addjj(i32 0, i32 2) #2
  store i32 %2, i32 addrspace(1)* %0, align 4, !tbaa !16
  %3 = tail call spir_func i32 @_Z30sub_group_clustered_reduce_muljj(i32 0, i32 2) #2
  %4 = getelementptr inbounds i32, i32 addrspace(1)* %0, i64 1
  store i32 %3, i32 addrspace(1)* %4, align 4, !tbaa !16
  %5 = tail call spir_func i32 @_Z30sub_group_clustered_reduce_minjj(i32 0, i32 2) #2
  %6 = getelementptr inbounds i32, i32 addrspace(1)* %0, i64 2
  store i32 %5, i32 addrspace(1)* %6, align 4, !tbaa !16
  %7 = tail call spir_func i32 @_Z30sub_group_clustered_reduce_maxjj(i32 0, i32 2) #2
  %8 = getelementptr inbounds i32, i32 addrspace(1)* %0, i64 3
  store i32 %7, i32 addrspace(1)* %8, align 4, !tbaa !16
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func i32 @_Z30sub_group_clustered_reduce_addjj(i32, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i32 @_Z30sub_group_clustered_reduce_muljj(i32, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i32 @_Z30sub_group_clustered_reduce_minjj(i32, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i32 @_Z30sub_group_clustered_reduce_maxjj(i32, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformIAdd %[[long]] %[[ScopeSubgroup]] ClusteredReduce %[[long_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformIMul %[[long]] %[[ScopeSubgroup]] ClusteredReduce %[[long_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformSMin %[[long]] %[[ScopeSubgroup]] ClusteredReduce %[[long_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformSMax %[[long]] %[[ScopeSubgroup]] ClusteredReduce %[[long_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredArithmeticLong(i64 addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !19 !kernel_arg_base_type !19 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func i64 @_Z30sub_group_clustered_reduce_addlj(i64 0, i32 2) #2
  store i64 %2, i64 addrspace(1)* %0, align 8, !tbaa !20
  %3 = tail call spir_func i64 @_Z30sub_group_clustered_reduce_mullj(i64 0, i32 2) #2
  %4 = getelementptr inbounds i64, i64 addrspace(1)* %0, i64 1
  store i64 %3, i64 addrspace(1)* %4, align 8, !tbaa !20
  %5 = tail call spir_func i64 @_Z30sub_group_clustered_reduce_minlj(i64 0, i32 2) #2
  %6 = getelementptr inbounds i64, i64 addrspace(1)* %0, i64 2
  store i64 %5, i64 addrspace(1)* %6, align 8, !tbaa !20
  %7 = tail call spir_func i64 @_Z30sub_group_clustered_reduce_maxlj(i64 0, i32 2) #2
  %8 = getelementptr inbounds i64, i64 addrspace(1)* %0, i64 3
  store i64 %7, i64 addrspace(1)* %8, align 8, !tbaa !20
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func i64 @_Z30sub_group_clustered_reduce_addlj(i64, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i64 @_Z30sub_group_clustered_reduce_mullj(i64, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i64 @_Z30sub_group_clustered_reduce_minlj(i64, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i64 @_Z30sub_group_clustered_reduce_maxlj(i64, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformIAdd %[[long]] %[[ScopeSubgroup]] ClusteredReduce %[[long_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformIMul %[[long]] %[[ScopeSubgroup]] ClusteredReduce %[[long_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformUMin %[[long]] %[[ScopeSubgroup]] ClusteredReduce %[[long_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformUMax %[[long]] %[[ScopeSubgroup]] ClusteredReduce %[[long_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredArithmeticULong(i64 addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !22 !kernel_arg_base_type !22 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func i64 @_Z30sub_group_clustered_reduce_addmj(i64 0, i32 2) #2
  store i64 %2, i64 addrspace(1)* %0, align 8, !tbaa !20
  %3 = tail call spir_func i64 @_Z30sub_group_clustered_reduce_mulmj(i64 0, i32 2) #2
  %4 = getelementptr inbounds i64, i64 addrspace(1)* %0, i64 1
  store i64 %3, i64 addrspace(1)* %4, align 8, !tbaa !20
  %5 = tail call spir_func i64 @_Z30sub_group_clustered_reduce_minmj(i64 0, i32 2) #2
  %6 = getelementptr inbounds i64, i64 addrspace(1)* %0, i64 2
  store i64 %5, i64 addrspace(1)* %6, align 8, !tbaa !20
  %7 = tail call spir_func i64 @_Z30sub_group_clustered_reduce_maxmj(i64 0, i32 2) #2
  %8 = getelementptr inbounds i64, i64 addrspace(1)* %0, i64 3
  store i64 %7, i64 addrspace(1)* %8, align 8, !tbaa !20
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func i64 @_Z30sub_group_clustered_reduce_addmj(i64, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i64 @_Z30sub_group_clustered_reduce_mulmj(i64, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i64 @_Z30sub_group_clustered_reduce_minmj(i64, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i64 @_Z30sub_group_clustered_reduce_maxmj(i64, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformFAdd %[[float]] %[[ScopeSubgroup]] ClusteredReduce %[[float_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformFMul %[[float]] %[[ScopeSubgroup]] ClusteredReduce %[[float_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformFMin %[[float]] %[[ScopeSubgroup]] ClusteredReduce %[[float_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformFMax %[[float]] %[[ScopeSubgroup]] ClusteredReduce %[[float_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredArithmeticFloat(float addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !23 !kernel_arg_base_type !23 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func float @_Z30sub_group_clustered_reduce_addfj(float 0.000000e+00, i32 2) #2
  store float %2, float addrspace(1)* %0, align 4, !tbaa !24
  %3 = tail call spir_func float @_Z30sub_group_clustered_reduce_mulfj(float 0.000000e+00, i32 2) #2
  %4 = getelementptr inbounds float, float addrspace(1)* %0, i64 1
  store float %3, float addrspace(1)* %4, align 4, !tbaa !24
  %5 = tail call spir_func float @_Z30sub_group_clustered_reduce_minfj(float 0.000000e+00, i32 2) #2
  %6 = getelementptr inbounds float, float addrspace(1)* %0, i64 2
  store float %5, float addrspace(1)* %6, align 4, !tbaa !24
  %7 = tail call spir_func float @_Z30sub_group_clustered_reduce_maxfj(float 0.000000e+00, i32 2) #2
  %8 = getelementptr inbounds float, float addrspace(1)* %0, i64 3
  store float %7, float addrspace(1)* %8, align 4, !tbaa !24
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func float @_Z30sub_group_clustered_reduce_addfj(float, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func float @_Z30sub_group_clustered_reduce_mulfj(float, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func float @_Z30sub_group_clustered_reduce_minfj(float, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func float @_Z30sub_group_clustered_reduce_maxfj(float, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformFAdd %[[half]] %[[ScopeSubgroup]] ClusteredReduce %[[half_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformFMul %[[half]] %[[ScopeSubgroup]] ClusteredReduce %[[half_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformFMin %[[half]] %[[ScopeSubgroup]] ClusteredReduce %[[half_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformFMax %[[half]] %[[ScopeSubgroup]] ClusteredReduce %[[half_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredArithmeticHalf(half addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !26 !kernel_arg_base_type !26 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func half @_Z30sub_group_clustered_reduce_addDhj(half 0xH0000, i32 2) #2
  store half %2, half addrspace(1)* %0, align 2, !tbaa !27
  %3 = tail call spir_func half @_Z30sub_group_clustered_reduce_mulDhj(half 0xH0000, i32 2) #2
  %4 = getelementptr inbounds half, half addrspace(1)* %0, i64 1
  store half %3, half addrspace(1)* %4, align 2, !tbaa !27
  %5 = tail call spir_func half @_Z30sub_group_clustered_reduce_minDhj(half 0xH0000, i32 2) #2
  %6 = getelementptr inbounds half, half addrspace(1)* %0, i64 2
  store half %5, half addrspace(1)* %6, align 2, !tbaa !27
  %7 = tail call spir_func half @_Z30sub_group_clustered_reduce_maxDhj(half 0xH0000, i32 2) #2
  %8 = getelementptr inbounds half, half addrspace(1)* %0, i64 3
  store half %7, half addrspace(1)* %8, align 2, !tbaa !27
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func half @_Z30sub_group_clustered_reduce_addDhj(half, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func half @_Z30sub_group_clustered_reduce_mulDhj(half, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func half @_Z30sub_group_clustered_reduce_minDhj(half, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func half @_Z30sub_group_clustered_reduce_maxDhj(half, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformFAdd %[[double]] %[[ScopeSubgroup]] ClusteredReduce %[[double_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformFMul %[[double]] %[[ScopeSubgroup]] ClusteredReduce %[[double_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformFMin %[[double]] %[[ScopeSubgroup]] ClusteredReduce %[[double_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformFMax %[[double]] %[[ScopeSubgroup]] ClusteredReduce %[[double_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredArithmeticDouble(double addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !29 !kernel_arg_base_type !29 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func double @_Z30sub_group_clustered_reduce_adddj(double 0.000000e+00, i32 2) #2
  store double %2, double addrspace(1)* %0, align 8, !tbaa !30
  %3 = tail call spir_func double @_Z30sub_group_clustered_reduce_muldj(double 0.000000e+00, i32 2) #2
  %4 = getelementptr inbounds double, double addrspace(1)* %0, i64 1
  store double %3, double addrspace(1)* %4, align 8, !tbaa !30
  %5 = tail call spir_func double @_Z30sub_group_clustered_reduce_mindj(double 0.000000e+00, i32 2) #2
  %6 = getelementptr inbounds double, double addrspace(1)* %0, i64 2
  store double %5, double addrspace(1)* %6, align 8, !tbaa !30
  %7 = tail call spir_func double @_Z30sub_group_clustered_reduce_maxdj(double 0.000000e+00, i32 2) #2
  %8 = getelementptr inbounds double, double addrspace(1)* %0, i64 3
  store double %7, double addrspace(1)* %8, align 8, !tbaa !30
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func double @_Z30sub_group_clustered_reduce_adddj(double, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func double @_Z30sub_group_clustered_reduce_muldj(double, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func double @_Z30sub_group_clustered_reduce_mindj(double, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func double @_Z30sub_group_clustered_reduce_maxdj(double, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseAnd %[[char]] %[[ScopeSubgroup]] ClusteredReduce %[[char_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseOr  %[[char]] %[[ScopeSubgroup]] ClusteredReduce %[[char_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseXor %[[char]] %[[ScopeSubgroup]] ClusteredReduce %[[char_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredBitwiseChar(i8 addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !5 !kernel_arg_base_type !5 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func signext i8 @_Z30sub_group_clustered_reduce_andcj(i8 signext 0, i32 2) #2
  store i8 %2, i8 addrspace(1)* %0, align 1, !tbaa !7
  %3 = tail call spir_func signext i8 @_Z29sub_group_clustered_reduce_orcj(i8 signext 0, i32 2) #2
  %4 = getelementptr inbounds i8, i8 addrspace(1)* %0, i64 1
  store i8 %3, i8 addrspace(1)* %4, align 1, !tbaa !7
  %5 = tail call spir_func signext i8 @_Z30sub_group_clustered_reduce_xorcj(i8 signext 0, i32 2) #2
  %6 = getelementptr inbounds i8, i8 addrspace(1)* %0, i64 2
  store i8 %5, i8 addrspace(1)* %6, align 1, !tbaa !7
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func signext i8 @_Z30sub_group_clustered_reduce_andcj(i8 signext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func signext i8 @_Z29sub_group_clustered_reduce_orcj(i8 signext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func signext i8 @_Z30sub_group_clustered_reduce_xorcj(i8 signext, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseAnd %[[char]] %[[ScopeSubgroup]] ClusteredReduce %[[char_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseOr  %[[char]] %[[ScopeSubgroup]] ClusteredReduce %[[char_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseXor %[[char]] %[[ScopeSubgroup]] ClusteredReduce %[[char_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredBitwiseUChar(i8 addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !10 !kernel_arg_base_type !10 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func zeroext i8 @_Z30sub_group_clustered_reduce_andhj(i8 zeroext 0, i32 2) #2
  store i8 %2, i8 addrspace(1)* %0, align 1, !tbaa !7
  %3 = tail call spir_func zeroext i8 @_Z29sub_group_clustered_reduce_orhj(i8 zeroext 0, i32 2) #2
  %4 = getelementptr inbounds i8, i8 addrspace(1)* %0, i64 1
  store i8 %3, i8 addrspace(1)* %4, align 1, !tbaa !7
  %5 = tail call spir_func zeroext i8 @_Z30sub_group_clustered_reduce_xorhj(i8 zeroext 0, i32 2) #2
  %6 = getelementptr inbounds i8, i8 addrspace(1)* %0, i64 2
  store i8 %5, i8 addrspace(1)* %6, align 1, !tbaa !7
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func zeroext i8 @_Z30sub_group_clustered_reduce_andhj(i8 zeroext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func zeroext i8 @_Z29sub_group_clustered_reduce_orhj(i8 zeroext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func zeroext i8 @_Z30sub_group_clustered_reduce_xorhj(i8 zeroext, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseAnd %[[short]] %[[ScopeSubgroup]] ClusteredReduce %[[short_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseOr  %[[short]] %[[ScopeSubgroup]] ClusteredReduce %[[short_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseXor %[[short]] %[[ScopeSubgroup]] ClusteredReduce %[[short_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredBitwiseShort(i16 addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !11 !kernel_arg_base_type !11 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func signext i16 @_Z30sub_group_clustered_reduce_andsj(i16 signext 0, i32 2) #2
  store i16 %2, i16 addrspace(1)* %0, align 2, !tbaa !12
  %3 = tail call spir_func signext i16 @_Z29sub_group_clustered_reduce_orsj(i16 signext 0, i32 2) #2
  %4 = getelementptr inbounds i16, i16 addrspace(1)* %0, i64 1
  store i16 %3, i16 addrspace(1)* %4, align 2, !tbaa !12
  %5 = tail call spir_func signext i16 @_Z30sub_group_clustered_reduce_xorsj(i16 signext 0, i32 2) #2
  %6 = getelementptr inbounds i16, i16 addrspace(1)* %0, i64 2
  store i16 %5, i16 addrspace(1)* %6, align 2, !tbaa !12
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func signext i16 @_Z30sub_group_clustered_reduce_andsj(i16 signext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func signext i16 @_Z29sub_group_clustered_reduce_orsj(i16 signext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func signext i16 @_Z30sub_group_clustered_reduce_xorsj(i16 signext, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseAnd %[[short]] %[[ScopeSubgroup]] ClusteredReduce %[[short_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseOr  %[[short]] %[[ScopeSubgroup]] ClusteredReduce %[[short_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseXor %[[short]] %[[ScopeSubgroup]] ClusteredReduce %[[short_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredBitwiseUShort(i16 addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !14 !kernel_arg_base_type !14 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func zeroext i16 @_Z30sub_group_clustered_reduce_andtj(i16 zeroext 0, i32 2) #2
  store i16 %2, i16 addrspace(1)* %0, align 2, !tbaa !12
  %3 = tail call spir_func zeroext i16 @_Z29sub_group_clustered_reduce_ortj(i16 zeroext 0, i32 2) #2
  %4 = getelementptr inbounds i16, i16 addrspace(1)* %0, i64 1
  store i16 %3, i16 addrspace(1)* %4, align 2, !tbaa !12
  %5 = tail call spir_func zeroext i16 @_Z30sub_group_clustered_reduce_xortj(i16 zeroext 0, i32 2) #2
  %6 = getelementptr inbounds i16, i16 addrspace(1)* %0, i64 2
  store i16 %5, i16 addrspace(1)* %6, align 2, !tbaa !12
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func zeroext i16 @_Z30sub_group_clustered_reduce_andtj(i16 zeroext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func zeroext i16 @_Z29sub_group_clustered_reduce_ortj(i16 zeroext, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func zeroext i16 @_Z30sub_group_clustered_reduce_xortj(i16 zeroext, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseAnd %[[int]] %[[ScopeSubgroup]] ClusteredReduce %[[int_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseOr  %[[int]] %[[ScopeSubgroup]] ClusteredReduce %[[int_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseXor %[[int]] %[[ScopeSubgroup]] ClusteredReduce %[[int_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredBitwiseInt(i32 addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !15 !kernel_arg_base_type !15 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func i32 @_Z30sub_group_clustered_reduce_andij(i32 0, i32 2) #2
  store i32 %2, i32 addrspace(1)* %0, align 4, !tbaa !16
  %3 = tail call spir_func i32 @_Z29sub_group_clustered_reduce_orij(i32 0, i32 2) #2
  %4 = getelementptr inbounds i32, i32 addrspace(1)* %0, i64 1
  store i32 %3, i32 addrspace(1)* %4, align 4, !tbaa !16
  %5 = tail call spir_func i32 @_Z30sub_group_clustered_reduce_xorij(i32 0, i32 2) #2
  %6 = getelementptr inbounds i32, i32 addrspace(1)* %0, i64 2
  store i32 %5, i32 addrspace(1)* %6, align 4, !tbaa !16
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func i32 @_Z30sub_group_clustered_reduce_andij(i32, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i32 @_Z29sub_group_clustered_reduce_orij(i32, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i32 @_Z30sub_group_clustered_reduce_xorij(i32, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseAnd %[[int]] %[[ScopeSubgroup]] ClusteredReduce %[[int_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseOr  %[[int]] %[[ScopeSubgroup]] ClusteredReduce %[[int_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseXor %[[int]] %[[ScopeSubgroup]] ClusteredReduce %[[int_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredBitwiseUInt(i32 addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !18 !kernel_arg_base_type !18 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func i32 @_Z30sub_group_clustered_reduce_andjj(i32 0, i32 2) #2
  store i32 %2, i32 addrspace(1)* %0, align 4, !tbaa !16
  %3 = tail call spir_func i32 @_Z29sub_group_clustered_reduce_orjj(i32 0, i32 2) #2
  %4 = getelementptr inbounds i32, i32 addrspace(1)* %0, i64 1
  store i32 %3, i32 addrspace(1)* %4, align 4, !tbaa !16
  %5 = tail call spir_func i32 @_Z30sub_group_clustered_reduce_xorjj(i32 0, i32 2) #2
  %6 = getelementptr inbounds i32, i32 addrspace(1)* %0, i64 2
  store i32 %5, i32 addrspace(1)* %6, align 4, !tbaa !16
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func i32 @_Z30sub_group_clustered_reduce_andjj(i32, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i32 @_Z29sub_group_clustered_reduce_orjj(i32, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i32 @_Z30sub_group_clustered_reduce_xorjj(i32, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseAnd %[[long]] %[[ScopeSubgroup]] ClusteredReduce %[[long_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseOr  %[[long]] %[[ScopeSubgroup]] ClusteredReduce %[[long_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseXor %[[long]] %[[ScopeSubgroup]] ClusteredReduce %[[long_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredBitwiseLong(i64 addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !19 !kernel_arg_base_type !19 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func i64 @_Z30sub_group_clustered_reduce_andlj(i64 0, i32 2) #2
  store i64 %2, i64 addrspace(1)* %0, align 8, !tbaa !20
  %3 = tail call spir_func i64 @_Z29sub_group_clustered_reduce_orlj(i64 0, i32 2) #2
  %4 = getelementptr inbounds i64, i64 addrspace(1)* %0, i64 1
  store i64 %3, i64 addrspace(1)* %4, align 8, !tbaa !20
  %5 = tail call spir_func i64 @_Z30sub_group_clustered_reduce_xorlj(i64 0, i32 2) #2
  %6 = getelementptr inbounds i64, i64 addrspace(1)* %0, i64 2
  store i64 %5, i64 addrspace(1)* %6, align 8, !tbaa !20
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func i64 @_Z30sub_group_clustered_reduce_andlj(i64, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i64 @_Z29sub_group_clustered_reduce_orlj(i64, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i64 @_Z30sub_group_clustered_reduce_xorlj(i64, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseAnd %[[long]] %[[ScopeSubgroup]] ClusteredReduce %[[long_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseOr  %[[long]] %[[ScopeSubgroup]] ClusteredReduce %[[long_0]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformBitwiseXor %[[long]] %[[ScopeSubgroup]] ClusteredReduce %[[long_0]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredBitwiseULong(i64 addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !22 !kernel_arg_base_type !22 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func i64 @_Z30sub_group_clustered_reduce_andmj(i64 0, i32 2) #2
  store i64 %2, i64 addrspace(1)* %0, align 8, !tbaa !20
  %3 = tail call spir_func i64 @_Z29sub_group_clustered_reduce_ormj(i64 0, i32 2) #2
  %4 = getelementptr inbounds i64, i64 addrspace(1)* %0, i64 1
  store i64 %3, i64 addrspace(1)* %4, align 8, !tbaa !20
  %5 = tail call spir_func i64 @_Z30sub_group_clustered_reduce_xormj(i64 0, i32 2) #2
  %6 = getelementptr inbounds i64, i64 addrspace(1)* %0, i64 2
  store i64 %5, i64 addrspace(1)* %6, align 8, !tbaa !20
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func i64 @_Z30sub_group_clustered_reduce_andmj(i64, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i64 @_Z29sub_group_clustered_reduce_ormj(i64, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i64 @_Z30sub_group_clustered_reduce_xormj(i64, i32) local_unnamed_addr #1

; CHECK-SPIRV: OpFunction
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformLogicalAnd %[[bool]] %[[ScopeSubgroup]] ClusteredReduce %[[false]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformLogicalOr  %[[bool]] %[[ScopeSubgroup]] ClusteredReduce %[[false]] %[[int_2]]
; CHECK-SPIRV: %{{[0-9]+}} = OpGroupNonUniformLogicalXor %[[bool]] %[[ScopeSubgroup]] ClusteredReduce %[[false]] %[[int_2]]
; CHECK-SPIRV: OpFunctionEnd

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @testClusteredLogical(i32 addrspace(1)* nocapture) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !15 !kernel_arg_base_type !15 !kernel_arg_type_qual !6 {
  %2 = tail call spir_func i32 @_Z38sub_group_clustered_reduce_logical_andij(i32 0, i32 2) #2
  store i32 %2, i32 addrspace(1)* %0, align 4, !tbaa !16
  %3 = tail call spir_func i32 @_Z37sub_group_clustered_reduce_logical_orij(i32 0, i32 2) #2
  %4 = getelementptr inbounds i32, i32 addrspace(1)* %0, i64 1
  store i32 %3, i32 addrspace(1)* %4, align 4, !tbaa !16
  %5 = tail call spir_func i32 @_Z38sub_group_clustered_reduce_logical_xorij(i32 0, i32 2) #2
  %6 = getelementptr inbounds i32, i32 addrspace(1)* %0, i64 2
  store i32 %5, i32 addrspace(1)* %6, align 4, !tbaa !16
  ret void
}

; Function Attrs: convergent
declare dso_local spir_func i32 @_Z38sub_group_clustered_reduce_logical_andij(i32, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i32 @_Z37sub_group_clustered_reduce_logical_orij(i32, i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local spir_func i32 @_Z38sub_group_clustered_reduce_logical_xorij(i32, i32) local_unnamed_addr #1

attributes #0 = { convergent nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "denorms-are-zero"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "uniform-work-group-size"="true" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { convergent "correctly-rounded-divide-sqrt-fp-math"="false" "denorms-are-zero"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { convergent nounwind }

!llvm.module.flags = !{!0}
!opencl.ocl.version = !{!1}
!opencl.spir.version = !{!1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, i32 2}
!2 = !{!"clang version 9.0.1 (https://github.com/llvm/llvm-project.git cb6d58d1dcf36a29ae5dd24ff891d6552f00bac7)"}
!3 = !{i32 1}
!4 = !{!"none"}
!5 = !{!"char*"}
!6 = !{!""}
!7 = !{!8, !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{!"uchar*"}
!11 = !{!"short*"}
!12 = !{!13, !13, i64 0}
!13 = !{!"short", !8, i64 0}
!14 = !{!"ushort*"}
!15 = !{!"int*"}
!16 = !{!17, !17, i64 0}
!17 = !{!"int", !8, i64 0}
!18 = !{!"uint*"}
!19 = !{!"long*"}
!20 = !{!21, !21, i64 0}
!21 = !{!"long", !8, i64 0}
!22 = !{!"ulong*"}
!23 = !{!"float*"}
!24 = !{!25, !25, i64 0}
!25 = !{!"float", !8, i64 0}
!26 = !{!"half*"}
!27 = !{!28, !28, i64 0}
!28 = !{!"half", !8, i64 0}
!29 = !{!"double*"}
!30 = !{!31, !31, i64 0}
!31 = !{!"double", !8, i64 0}
