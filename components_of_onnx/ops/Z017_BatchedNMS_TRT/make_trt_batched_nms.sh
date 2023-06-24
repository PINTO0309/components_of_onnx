#!/bin/bash

# https://github.com/NVIDIA/TensorRT/tree/main/plugin/batchedNMSPlugin

# attrs["plugin_version"] = "1"
# attrs["shareLocation"] = 1
# attrs["backgroundLabelId"] = -1
# attrs["numClasses"] = 4
# attrs["topK"] = topK    # number of bounding boxes for nms eg 1000s
# attrs["keepTopK"] = keepTopK # bounding boxes to be kept per image eg 20
# attrs["scoreThreshold"] = 0.20
# attrs["iouThreshold"] = 0.45
# attrs["isNormalized"] = False
# attrs["clipBoxes"] = False
# attrs['scoreBits'] = 16

# bool	shareLocation	If set to true, the boxes input are shared across all classes. If set to false, the boxes input should account for per-class box data.
# int	backgroundLabelId	The label ID for the background class. If there is no background class, set it to -1.
# int	numClasses	The number of classes in the network.
# int	topK	The number of bounding boxes to be fed into the NMS step. Maximum allowed value is 4096.
# int	keepTopK	The number of total bounding boxes to be kept per-image after the NMS step. Should be less than or equal to the topK value.
# float	scoreThreshold	The scalar threshold for score (low scoring boxes are removed).
# float	iouThreshold	The scalar threshold for IOU (new boxes that have high IOU overlap with previously selected boxes are removed).
# bool	isNormalized	Set to false if the box coordinates are not normalized, meaning they are not in the range [0,1]. Defaults to true.
# bool	clipBoxes	Forcibly restrict bounding boxes to the normalized range [0,1]. Only applicable if isNormalized is also true. Defaults to true.
# int	scoreBits	The number of bits to represent score values(confidences) during radix sort. This valid range is 0 < scoreBits <= 10. The default value is 16(which means to use full bits in radix sort). Setting this parameter to any invalid value will result in the same effect as setting it to 16. This parameter can be tuned to strike for a best trade-off between performance and accuracy. Lowering scoreBits will improve performance but with some minor degradation to the accuracy. This parameter is only valid for FP16 data type for now.
# bool	caffeSemantics	Set to false to disable Caffe semantics for IOU calculation. In Caffe, width and height are incremented by '1' if bbox coordinates are not normalized. Defaults to true.

OPSET=11
BOXES=3549
NUMBER_CLASSES=1
CLASSES=16
MAX_OUTPUT_BOXES=20

# Standard NMS Mode
sog4onnx \
--op_type BatchedNMS_TRT \
--opset ${OPSET} \
--op_name trt_nms_batched_${OPSET} \
--input_variables boxes float32 [1,${BOXES},${NUMBER_CLASSES},4] \
--input_variables scores float32 [1,${BOXES},${CLASSES}] \
--attributes plugin_version str 1 \
--attributes shareLocation int64 1 \
--attributes backgroundLabelId int64 -1 \
--attributes numClasses int64 ${CLASSES} \
--attributes topK int64 1000 \
--attributes keepTopK int64 ${MAX_OUTPUT_BOXES} \
--attributes scoreThreshold float32 0.25 \
--attributes iouThreshold float32 0.45 \
--attributes isNormalized bool False \
--attributes clipBoxes bool False \
--attributes scoreBits int64 16 \
--output_variables num_detections int32 [1,1] \
--output_variables nmsed_boxes float32 [1,${MAX_OUTPUT_BOXES},4] \
--output_variables nmsed_scores float32 [1,${MAX_OUTPUT_BOXES}] \
--output_variables nmsed_classes float32 [1,${MAX_OUTPUT_BOXES}]
