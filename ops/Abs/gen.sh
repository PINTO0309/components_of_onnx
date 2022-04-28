#!/bin/bash

OP=Abs
LOWEROP=${OP,,}

OPSET=1
sog4onnx \
--op_type ${OP} \
--opset ${OPSET} \
--op_name ${LOWEROP}${OPSET} \
--input_variables ${LOWEROP}${OPSET}_input float32 [1] \
--output_variables ${LOWEROP}${OPSET}_output float32 [1] \
--attributes consumed_inputs int64 [0] \
--output_onnx_file_path ${OP}${OPSET}.onnx \
--non_verbose

OPSET=6
sog4onnx \
--op_type ${OP} \
--opset ${OPSET} \
--op_name ${LOWEROP}${OPSET} \
--input_variables ${LOWEROP}${OPSET}_input float32 [1] \
--output_variables ${LOWEROP}${OPSET}_output float32 [1] \
--output_onnx_file_path ${OP}${OPSET}.onnx \
--non_verbose

OPSET=13
sog4onnx \
--op_type ${OP} \
--opset ${OPSET} \
--op_name ${LOWEROP}${OPSET} \
--input_variables ${LOWEROP}${OPSET}_input float32 [1] \
--output_variables ${LOWEROP}${OPSET}_output float32 [1] \
--output_onnx_file_path ${OP}${OPSET}.onnx \
--non_verbose
