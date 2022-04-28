#!/bin/bash

OP=Asin
LOWEROP=${OP,,}

OPSET=7
sog4onnx \
--op_type ${OP} \
--opset ${OPSET} \
--op_name ${LOWEROP}${OPSET} \
--input_variables ${LOWEROP}${OPSET}_input float32 [1] \
--output_variables ${LOWEROP}${OPSET}_output float32 [1] \
--output_onnx_file_path ${OP}${OPSET}.onnx \
--non_verbose
