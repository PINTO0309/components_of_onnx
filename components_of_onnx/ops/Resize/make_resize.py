import torch
import torch.nn as nn
import torchvision.transforms.functional as F


class Model1(nn.Module):
    def __init__(self):
        super(Model1, self).__init__()

    def forward(self,x):
        return F.resize(img=x, size=(x.shape[-2]*2, x.shape[-1]*2))

model = Model1()
shape = [1,3,112,112]
x = torch.randn(shape)
OPSETS = [13,11,10]

for opset in OPSETS:
    onnx_file = f'resize_{opset}.onnx'
    torch.onnx.export(
        model,
        args=(x),
        f=onnx_file,
        opset_version=opset,
        input_names=['input'],
        output_names=['output'],
    )
    import onnx
    from onnxsim import simplify
    model_onnx2 = onnx.load(onnx_file)
    model_simp, check = simplify(model_onnx2)
    onnx.save(model_simp, onnx_file)

