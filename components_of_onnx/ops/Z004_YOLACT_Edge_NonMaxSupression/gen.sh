#!/bin/bash

sog4onnx \
--op_type Constant \
--opset 11 \
--op_name max_output_boxes_per_class_const \
--output_variables max_output_boxes_per_class int64 [1] \
--attributes value int64 [20] \
--output_onnx_file_path Constant_max_output_boxes_per_class.onnx

sog4onnx \
--op_type Constant \
--opset 11 \
--op_name iou_threshold_const \
--output_variables iou_threshold float32 [1] \
--attributes value float32 [0.5] \
--output_onnx_file_path Constant_iou_threshold.onnx

sog4onnx \
--op_type Constant \
--opset 11 \
--op_name score_threshold_const \
--output_variables score_threshold float32 [1] \
--attributes value float32 [-inf] \
--output_onnx_file_path Constant_score_threshold.onnx


OP=NonMaxSuppression
LOWEROP=${OP,,}
NUM_BATCHES=1
SPATIAL_DIMENSION=19248
NUM_CLASSES=80
OPSET=11
sog4onnx \
--op_type ${OP} \
--opset ${OPSET} \
--op_name ${LOWEROP}${OPSET} \
--input_variables boxes_var float32 [${NUM_BATCHES},${SPATIAL_DIMENSION},4] \
--input_variables scores_var float32 [${NUM_BATCHES},${NUM_CLASSES},${SPATIAL_DIMENSION}] \
--input_variables max_output_boxes_per_class_var int64 [1] \
--input_variables iou_threshold_var float32 [1] \
--input_variables score_threshold_var float32 [1] \
--output_variables selected_indices int64 [\'N\',3] \
--attributes center_point_box int64 0 \
--output_onnx_file_path ${OP}${OPSET}.onnx


snc4onnx \
--input_onnx_file_paths Constant_max_output_boxes_per_class.onnx NonMaxSuppression11.onnx \
--srcop_destop max_output_boxes_per_class max_output_boxes_per_class_var \
--output_onnx_file_path NonMaxSuppression11.onnx

snc4onnx \
--input_onnx_file_paths Constant_iou_threshold.onnx NonMaxSuppression11.onnx \
--srcop_destop iou_threshold iou_threshold_var \
--output_onnx_file_path NonMaxSuppression11.onnx

snc4onnx \
--input_onnx_file_paths Constant_score_threshold.onnx NonMaxSuppression11.onnx \
--srcop_destop score_threshold score_threshold_var \
--output_onnx_file_path NonMaxSuppression11.onnx