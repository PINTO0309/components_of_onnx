import torch
import torch.nn as nn
import numpy as np
import cv2

class AffineTransform_Layer(nn.Module):
    def __init__(self):
        super(AffineTransform_Layer, self).__init__()

    def forward(self, src, dst):
        A = torch.cat([src, torch.ones((3, 1))], axis=1)
        B = dst
        # x = torch.linalg.solve(A, B)
        print(f'A', A.shape)
        print(f'B', B.shape)
        x = torch.linalg.inv(A) @ B
        x = torch.transpose(x, 1, 0)
        return x


class AffineTransform_Before_Inv_Layer(nn.Module):
    def __init__(self):
        super(AffineTransform_Before_Inv_Layer, self).__init__()

    def forward(self, src, dst):
        A = torch.cat([src, torch.ones((3, 1))], axis=1)
        B = dst
        return A, B


class AffineTransform_After_Inv_Layer(nn.Module):
    def __init__(self):
        super(AffineTransform_After_Inv_Layer, self).__init__()

    def forward(self, inv_A, B):
        x = inv_A @ B
        x = torch.transpose(x, 1, 0)
        # x = torch.round(input=x, decimals=7, out=None)
        # x = x.round(decimals=7)
        return x



OPSET = 11
model = AffineTransform_Layer()
before_model = AffineTransform_Before_Inv_Layer()
after_model = AffineTransform_After_Inv_Layer()

src = torch.tensor(
    np.asarray(
        [
            [109.    , 173.    ],
            [109.    ,  10.8125],
            [-53.1875,  10.8125]
        ],
        dtype=np.float32
    )
)
dst = torch.tensor(
    np.asarray(
        [
            [ 96., 128.],
            [ 96.,  32.],
            [  0.,  32.]
        ],
        dtype=np.float32
    )
)

warp_mat = cv2.getAffineTransform(np.float32(src), np.float32(dst))
warp_mat_custom = model(src, dst)

print('src', src.shape)
print('dst', src.shape)
print('warp_mat', warp_mat.shape)
print(warp_mat)
print('warp_mat_custom', warp_mat_custom.numpy().shape)
print(warp_mat_custom.numpy())
print(f'warp_mat == warp_mat_custom: {np.allclose(warp_mat, warp_mat_custom.numpy())}')
a=0

"""
src torch.Size([3, 2])
dst torch.Size([3, 2])

A torch.Size([3, 3])
B torch.Size([3, 2])

warp_mat (2, 3)
    [[ 0.59190751 -0.         31.48208092]
    [ 0.          0.59190751 25.6       ]]
warp_mat_custom (2, 3)
    [[ 0.5919075  0.        31.482079 ]
    [ 0.         0.5919075 25.6      ]]

warp_mat == warp_mat_custom: True
"""

torch.onnx.export(
    before_model,
    (src, dst),
    f'affine_transform_before_inv_{OPSET}.onnx',
    input_names=['affine_src', 'affine_dst'],
    output_names=['output_affine_A', 'output_affine_B'],
    opset_version=OPSET,
)

output_affine_A, output_affine_B = before_model(src, dst)

torch.onnx.export(
    after_model,
    (output_affine_A, output_affine_B),
    f'affine_transform_after_inv_{OPSET}.onnx',
    input_names=['input_inv_A', 'input_B'],
    output_names=['output_affine'],
    opset_version=OPSET,
)
