import torch
import torch.nn as nn


class Model(nn.Module):
    def __init__(self, reduction:str='mean'):
        super(Model, self).__init__()

        self.reduction = reduction

    def forward(self, estimate, real):
        sum = torch.sum(torch.square(real - estimate))
        ret = None
        if self.reduction == 'mean':
            ret = torch.mean(sum)
        elif self.reduction == 'sum':
            ret = sum
        return ret


input_shape = [1,3,224,224]
x = torch.randn(input_shape)
y = torch.randn(input_shape)

reduction = 'mean'
model = Model(reduction=reduction)
onnx_file = f'mseloss_{reduction}_11.onnx'
torch.onnx.export(
    model,
    args=(x,x),
    f=onnx_file,
    opset_version=11,
    input_names=[
        'mseloss_input',
        'mseloss_target',
    ],
    output_names=[
        'mseloss_output',
    ],
)
import onnx
from onnxsim import simplify
model_onnx2 = onnx.load(onnx_file)
model_simp, check = simplify(model_onnx2)
onnx.save(model_simp, onnx_file)


reduction = 'sum'
model = Model(reduction=reduction)
onnx_file = f'mseloss_{reduction}_11.onnx'
torch.onnx.export(
    model,
    args=(x,x),
    f=onnx_file,
    opset_version=11,
    input_names=[
        'mseloss_input',
        'mseloss_target',
    ],
    output_names=[
        'mseloss_output',
    ],
)
import onnx
from onnxsim import simplify
model_onnx2 = onnx.load(onnx_file)
model_simp, check = simplify(model_onnx2)
onnx.save(model_simp, onnx_file)
