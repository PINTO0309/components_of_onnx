import cv2
import numpy as np
np.set_printoptions(suppress=True)
import onnxruntime

src = np.asarray(
    [
        [109.    , 173.    ],
        [109.    ,  10.8125],
        [-53.1875,  10.8125]
    ],
    dtype=np.float32
)
dst = np.asarray(
    [
        [ 96., 128.],
        [ 96.,  32.],
        [  0.,  32.]
    ],
    dtype=np.float32
)
warp_mat = cv2.getAffineTransform(np.float32(src), np.float32(dst))

onnx_session = onnxruntime.InferenceSession(
    'affine_transform_11.onnx',
    providers=['CPUExecutionProvider'],
)
onnx_warp_mat = onnx_session.run(None, {'affine_src': [src], 'affine_dst': [dst]})[0]

print('src', src.shape)
print(src)
print('dst', src.shape)
print(dst)
print('warp_mat', warp_mat.shape)
print(warp_mat)
print('onnx_warp_mat', onnx_warp_mat.shape)
print(onnx_warp_mat)

# print(np.round(onnx_warp_mat, decimals=7))

print(f'warp_mat == onnx_warp_mat: {np.allclose(warp_mat, onnx_warp_mat[0], atol=1e-4)}')

"""
onnx2json \
--input_onnx_file_path Inverse_11.onnx \
--output_json_path Inverse_16.json \
--json_indent 2

json2onnx \
--input_json_path Inverse_16.json \
--output_onnx_file_path Inverse_16.onnx

snc4onnx \
--input_onnx_file_paths affine_transform_before_inv_16.onnx Inverse_16.onnx \
--output_onnx_file_path 1.onnx \
--srcop_destop output_affine_A inverse_input

snc4onnx \
--input_onnx_file_paths 1.onnx affine_transform_after_inv_16.onnx \
--output_onnx_file_path affine_transform_16.onnx \
--srcop_destop inverse_output input_inv_A output_affine_B input_B

onnxsim affine_transform_16.onnx affine_transform_16.onnx
"""