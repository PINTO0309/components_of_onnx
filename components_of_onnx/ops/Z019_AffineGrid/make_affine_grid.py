import random
import torch
import torch.nn as nn
import numpy as np
import cv2
import onnx
seed = 0
random.seed(seed)
np.random.seed(seed)
torch.manual_seed(seed)
torch.backends.cudnn.benchmark = False
torch.backends.cudnn.deterministic = True
from onnxsim import simplify

# grid = F.affine_grid(src_norm_trans_dst_norm[:, :2, :], [B, C, dsize[0], dsize[1]], align_corners=align_corners)

# src_norm_trans_dst_norm: (1,3,3)
# B: 1
# C: 3
# dsize: (256,192)
# align_corners=True

def affine_grid(theta, size, align_corners=False):
    N, C, H, W = size
    grid = create_grid(N, C, H, W, align_corners)
    grid = grid.view(N, H * W, 3).bmm(theta.transpose(1, 2))
    grid = grid.view(N, H, W, 2)
    return grid

def create_grid(N, C, H, W, align_corners):
    grid = torch.empty((N, H, W, 3), dtype=torch.float32)
    grid.select(-1, 0).copy_(linspace_from_neg_one(W, align_corners))
    grid.select(-1, 1).copy_(linspace_from_neg_one(H, align_corners).unsqueeze_(-1))
    grid.select(-1, 2).fill_(1)
    return grid

def linspace_from_neg_one(num_steps, align_corners, dtype=torch.float32):
    r = torch.linspace(-1, 1, num_steps, dtype=torch.float32)
    if not align_corners:
        r = r * (num_steps - 1) / num_steps
    return r


class affine_grid_Layer(nn.Module):
    def __init__(self, align_corners):
        super(affine_grid_Layer, self).__init__()

        self.align_corners = align_corners

    def forward(self, theta, dst_size, align_corners=False):
        dst_norm_trans_src_norm = \
            affine_grid(
                theta=theta,
                size=dst_size,
                align_corners=align_corners,
            )
        return dst_norm_trans_src_norm


img = torch.randn([1,3,256,192], dtype=torch.float32)
dst_size = torch.tensor([1,3,256,192])
src_norm_trans_dst_norm = torch.randn([1,3,3], dtype=torch.float32)

OPSET = [11, 16]

affine_grid_Layer_model = \
    affine_grid_Layer(
        align_corners=True
    )
for opset in OPSET:
    model_file = f'affine_grid_aligncorners_true_{opset}.onnx'
    torch.onnx.export(
        affine_grid_Layer_model,
        (src_norm_trans_dst_norm[:, :2, :], dst_size),
        model_file,
        input_names=['input_theta', 'dst_image_size_nchw'],
        output_names=['output_grid'],
        opset_version=opset,
        dynamic_axes={
            'output_grid' : {0: 'N', 1: 'H', 2: 'W', 3: '2'},
        }
    )
    model_onnx1 = onnx.load(model_file)
    model_onnx1 = onnx.shape_inference.infer_shapes(model_onnx1)
    onnx.save(model_onnx1, model_file)
    model_onnx2 = onnx.load(model_file)
    model_simp, check = simplify(model_onnx2)
    onnx.save(model_simp, model_file)

affine_grid_Layer_model = \
    affine_grid_Layer(
        align_corners=False
    )
for opset in OPSET:
    model_file = f'affine_grid_aligncorners_false_{opset}.onnx'
    torch.onnx.export(
        affine_grid_Layer_model,
        (src_norm_trans_dst_norm[:, :2, :], dst_size),
        model_file,
        input_names=['input_theta', 'dst_image_size_nchw'],
        output_names=['output_grid'],
        opset_version=opset,
    )
    model_onnx1 = onnx.load(model_file)
    model_onnx1 = onnx.shape_inference.infer_shapes(model_onnx1)
    onnx.save(model_onnx1, model_file)
    model_onnx2 = onnx.load(model_file)
    model_simp, check = simplify(model_onnx2)
    onnx.save(model_simp, model_file)
