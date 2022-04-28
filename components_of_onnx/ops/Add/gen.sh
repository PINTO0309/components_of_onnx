#!/bin/bash

OP=Add
LOWEROP=${OP,,}

OPSET=1
sog4onnx \
--op_type ${OP} \
--opset ${OPSET} \
--op_name ${LOWEROP}${OPSET} \
--input_variables ${LOWEROP}${OPSET}_input1 float32 [1] \
--input_variables ${LOWEROP}${OPSET}_input2 float32 [1] \
--output_variables ${LOWEROP}${OPSET}_output float32 [1] \
--attributes broadcast int64 0 \
--attributes consumed_inputs int64 [0] \
--output_onnx_file_path ${OP}${OPSET}.onnx \
--non_verbose

OPSET=6
sog4onnx \
--op_type ${OP} \
--opset ${OPSET} \
--op_name ${LOWEROP}${OPSET} \
--input_variables ${LOWEROP}${OPSET}_input1 float32 [1] \
--input_variables ${LOWEROP}${OPSET}_input2 float32 [1] \
--output_variables ${LOWEROP}${OPSET}_output float32 [1] \
--attributes broadcast int64 0 \
--output_onnx_file_path ${OP}${OPSET}.onnx \
--non_verbose

OPSET=7
sog4onnx \
--op_type ${OP} \
--opset ${OPSET} \
--op_name ${LOWEROP}${OPSET} \
--input_variables ${LOWEROP}${OPSET}_input1 float32 [1] \
--input_variables ${LOWEROP}${OPSET}_input2 float32 [1] \
--output_variables ${LOWEROP}${OPSET}_output float32 [1] \
--output_onnx_file_path ${OP}${OPSET}.onnx \
--non_verbose

OPSET=13
sog4onnx \
--op_type ${OP} \
--opset ${OPSET} \
--op_name ${LOWEROP}${OPSET} \
--input_variables ${LOWEROP}${OPSET}_input1 float32 [1] \
--input_variables ${LOWEROP}${OPSET}_input2 float32 [1] \
--output_variables ${LOWEROP}${OPSET}_output float32 [1] \
--output_onnx_file_path ${OP}${OPSET}.onnx \
--non_verbose

OPSET=14
sog4onnx \
--op_type ${OP} \
--opset ${OPSET} \
--op_name ${LOWEROP}${OPSET} \
--input_variables ${LOWEROP}${OPSET}_input1 float32 [1] \
--input_variables ${LOWEROP}${OPSET}_input2 float32 [1] \
--output_variables ${LOWEROP}${OPSET}_output float32 [1] \
--output_onnx_file_path ${OP}${OPSET}.onnx \
--non_verbose