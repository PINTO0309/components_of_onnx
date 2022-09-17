#!/bin/bash

OPSET=11
BATCHES=1
BOXES_LIST=(
    "896"
    "2016"
)
CLASSES=1

for((i=0; i<${#BOXES_LIST[@]}; i++))
do
    BOXES=(`echo ${BOXES_LIST[i]}`)

    ################################################### NonMaxSuppression
    sog4onnx \
    --op_type Constant \
    --opset ${OPSET} \
    --op_name max_output_boxes_per_class_const \
    --output_variables max_output_boxes_per_class int64 [1] \
    --attributes value int64 [${BOXES}] \
    --output_onnx_file_path Constant_max_output_boxes_per_class.onnx

    sog4onnx \
    --op_type Constant \
    --opset ${OPSET} \
    --op_name iou_threshold_const \
    --output_variables iou_threshold float32 [1] \
    --attributes value float32 [0.3] \
    --output_onnx_file_path Constant_iou_threshold.onnx

    OP=NonMaxSuppression
    LOWEROP=${OP,,}
    sog4onnx \
    --op_type ${OP} \
    --opset ${OPSET} \
    --op_name ${LOWEROP}${OPSET} \
    --input_variables boxes_var float32 [${BATCHES},${BOXES},4] \
    --input_variables scores_var float32 [${BATCHES},${CLASSES},${BOXES}] \
    --input_variables max_output_boxes_per_class_var int64 [1] \
    --input_variables iou_threshold_var float32 [1] \
    --output_variables selected_indices int64 [\'N\',3] \
    --attributes center_point_box int64 0 \
    --output_onnx_file_path ${OP}${OPSET}_${BOXES}.onnx

    snc4onnx \
    --input_onnx_file_paths Constant_max_output_boxes_per_class.onnx ${OP}${OPSET}_${BOXES}.onnx \
    --srcop_destop max_output_boxes_per_class max_output_boxes_per_class_var \
    --output_onnx_file_path ${OP}${OPSET}_${BOXES}.onnx

    snc4onnx \
    --input_onnx_file_paths Constant_iou_threshold.onnx ${OP}${OPSET}_${BOXES}.onnx \
    --srcop_destop iou_threshold iou_threshold_var \
    --output_onnx_file_path ${OP}${OPSET}_${BOXES}.onnx

    soc4onnx \
    --input_onnx_file_path ${OP}${OPSET}_${BOXES}.onnx \
    --output_onnx_file_path ${OP}${OPSET}_${BOXES}.onnx \
    --opset ${OPSET}

    ################################################### Myriad workaround Mul
    OP=Mul
    LOWEROP=${OP,,}
    OPSET=${OPSET}
    sog4onnx \
    --op_type ${OP} \
    --opset ${OPSET} \
    --op_name ${LOWEROP}${OPSET} \
    --input_variables workaround_mul_a int64 [\'N\',3] \
    --input_variables workaround_mul_b int64 [1] \
    --output_variables workaround_mul_out int64 [\'N\',3] \
    --output_onnx_file_path ${OP}${OPSET}_workaround.onnx

    ############ Myriad workaround Constant
    sog4onnx \
    --op_type Constant \
    --opset ${OPSET} \
    --op_name workaround_mul_const_op \
    --output_variables workaround_mul_const int64 [1] \
    --attributes value int64 [1] \
    --output_onnx_file_path Constant_workaround_mul.onnx

    ############ Myriad workaround Mul + Myriad workaround Constant
    snc4onnx \
    --input_onnx_file_paths Constant_workaround_mul.onnx ${OP}${OPSET}_workaround.onnx \
    --srcop_destop workaround_mul_const workaround_mul_b \
    --output_onnx_file_path ${OP}${OPSET}_workaround.onnx

    ################################################### NonMaxSuppression + Myriad workaround Mul
    snc4onnx \
    --input_onnx_file_paths NonMaxSuppression${OPSET}_${BOXES}.onnx ${OP}${OPSET}_workaround.onnx \
    --srcop_destop selected_indices workaround_mul_a \
    --output_onnx_file_path NonMaxSuppression${OPSET}_${BOXES}.onnx

    ################################################### Cleaning
    rm Constant_iou_threshold.onnx
    rm Constant_max_output_boxes_per_class.onnx
    rm Constant_workaround_mul.onnx
    rm Mul11_workaround.onnx
done
