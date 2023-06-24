#!/bin/bash

# https://github.com/NVIDIA/TensorRT/tree/main/plugin/efficientNMSPlugin

# plugin_version="1",
# background_class=-1,  # no background class
# max_output_boxes=detections_per_img,
# score_threshold=score_thresh,
# iou_threshold=nms_thresh,
# score_activation=False,
# box_coding=0,

# float	score_threshold *	The scalar threshold for score (low scoring boxes are removed).
# float	iou_threshold	The scalar threshold for IOU (additional boxes that have high IOU overlap with previously selected boxes are removed).
# int	max_output_boxes	The maximum number of detections to output per image.
# int	background_class	The label ID for the background class. If there is no background class, set it to -1.
# bool	score_activation *	Set to true to apply sigmoid activation to the confidence scores during NMS operation.
# bool	class_agnostic	Set to true to do class-independent NMS; otherwise, boxes of different classes would be considered separately during NMS.
# int	box_coding	Coding type used for boxes (and anchors if applicable), 0 = BoxCorner, 1 = BoxCenterSize.

OPSET=11
BOXES=3549
CLASSES=16
MAX_OUTPUT_BOXES=20

# Standard NMS Mode
sog4onnx \
--op_type EfficientNMS_TRT \
--opset ${OPSET} \
--op_name trt_nms_efficient_std_${OPSET} \
--input_variables boxes float32 [1,${BOXES},4] \
--input_variables scores float32 [1,${BOXES},${CLASSES}] \
--attributes plugin_version str 1 \
--attributes score_threshold float32 0.25 \
--attributes iou_threshold float32 0.45 \
--attributes max_output_boxes int64 ${MAX_OUTPUT_BOXES} \
--attributes background_class int64 -1 \
--attributes score_activation bool False \
--attributes box_coding int64 0 \
--output_variables num_detections int32 [1,1] \
--output_variables detection_boxes float32 [1,${MAX_OUTPUT_BOXES},4] \
--output_variables detection_scores float32 [1,${MAX_OUTPUT_BOXES}] \
--output_variables detection_classes int32 [1,${MAX_OUTPUT_BOXES}]
