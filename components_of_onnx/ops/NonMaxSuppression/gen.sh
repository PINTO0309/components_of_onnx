#!/bin/bash

OP=NonMaxSuppression
LOWEROP=${OP,,}

NUM_BATCHES=1
SPATIAL_DIMENSION=100
NUM_CLASSES=80

OPSET=10
sog4onnx \
--op_type ${OP} \
--opset ${OPSET} \
--op_name ${LOWEROP}${OPSET} \
--input_variables boxes float32 [${NUM_BATCHES},${SPATIAL_DIMENSION},4] \
--input_variables scores float32 [${NUM_BATCHES},${NUM_CLASSES},${SPATIAL_DIMENSION}] \
--input_variables max_output_boxes_per_class int64 [1] \
--input_variables iou_threshold float32 [1] \
--input_variables score_threshold float32 [1] \
--output_variables selected_indices int64 [\'N\',3] \
--attributes center_point_box int64 0 \
--output_onnx_file_path ${OP}${OPSET}.onnx \
--non_verbose

OPSET=11
sog4onnx \
--op_type ${OP} \
--opset ${OPSET} \
--op_name ${LOWEROP}${OPSET} \
--input_variables boxes float32 [${NUM_BATCHES},${SPATIAL_DIMENSION},4] \
--input_variables scores float32 [${NUM_BATCHES},${NUM_CLASSES},${SPATIAL_DIMENSION}] \
--input_variables max_output_boxes_per_class int64 [1] \
--input_variables iou_threshold float32 [1] \
--input_variables score_threshold float32 [1] \
--output_variables selected_indices int64 [\'N\',3] \
--attributes center_point_box int64 0 \
--output_onnx_file_path ${OP}${OPSET}.onnx \
--non_verbose
