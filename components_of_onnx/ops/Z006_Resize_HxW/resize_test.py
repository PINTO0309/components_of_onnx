import numpy as np
import onnxruntime

onnx_session = onnxruntime.InferenceSession(
    'Resize.onnx',
    providers=[
        # (
        #     'TensorrtExecutionProvider', {
        #         'trt_engine_cache_enable': True,
        #         'trt_engine_cache_path': '.',
        #         'trt_fp16_enable': True,
        #     }
        # ),
        'CUDAExecutionProvider',
        'CPUExecutionProvider'
    ],
)

x = onnx_session.get_inputs()[0]
input_name_x = x.name
input_shape_x = x.shape

scales = onnx_session.get_inputs()[1]
input_name_scales = scales.name
input_shape_scales = x.shape

result = onnx_session.run(
    output_names=None,
    input_feed={
        input_name_x: np.ones([1,3,480,640], dtype=np.float32),
        input_name_scales: np.asarray([1,1,0.5,0.5], dtype=np.float32),
    },
)

print(f'result[0].shape: {result[0].shape}')