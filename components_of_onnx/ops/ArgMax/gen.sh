#!/bin/bash

OP=ArgMax
LOWEROP=${OP,,}

OPSET=1
sog4onnx \
--op_type ${OP} \
--opset ${OPSET} \
--op_name ${LOWEROP}${OPSET} \
--input_variables ${LOWEROP}${OPSET}_input1 float32 [1] \
--output_variables ${LOWEROP}${OPSET}_output int64 [1] \
--attributes axis int64 0 \
--attributes keepdims int64 1 \
--output_onnx_file_path ${OP}${OPSET}.onnx \
--non_verbose

OPSET=11
sog4onnx \
--op_type ${OP} \
--opset ${OPSET} \
--op_name ${LOWEROP}${OPSET} \
--input_variables ${LOWEROP}${OPSET}_input1 float32 [1] \
--output_variables ${LOWEROP}${OPSET}_output int64 [1] \
--attributes axis int64 0 \
--attributes keepdims int64 1 \
--output_onnx_file_path ${OP}${OPSET}.onnx \
--non_verbose

OPSET=12
sog4onnx \
--op_type ${OP} \
--opset ${OPSET} \
--op_name ${LOWEROP}${OPSET} \
--input_variables ${LOWEROP}${OPSET}_input1 float32 [1] \
--output_variables ${LOWEROP}${OPSET}_output int64 [1] \
--attributes axis int64 0 \
--attributes keepdims int64 1 \
--attributes select_last_index int64 0 \
--output_onnx_file_path ${OP}${OPSET}.onnx \
--non_verbose

OPSET=13
sog4onnx \
--op_type ${OP} \
--opset ${OPSET} \
--op_name ${LOWEROP}${OPSET} \
--input_variables ${LOWEROP}${OPSET}_input1 float32 [1] \
--output_variables ${LOWEROP}${OPSET}_output int64 [1] \
--attributes axis int64 0 \
--attributes keepdims int64 1 \
--attributes select_last_index int64 0 \
--output_onnx_file_path ${OP}${OPSET}.onnx \
--non_verbose