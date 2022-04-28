# [WIP] components_of_onnx

https://github.com/onnx/onnx/blob/main/docs/Operators.md

https://github.com/PINTO0309/simple-onnx-processing-tools

# Key concept
- [ ] Convert each and every operator in [Operators.md](https://github.com/onnx/onnx/blob/main/docs/Operators.md) into a single ONNX file and commit.
- [ ] Use [sog4onnx](https://github.com/PINTO0309/sog4onnx) to generate the ONNX model for a single OP.
- [ ] Use [sam4onnx](https://github.com/PINTO0309/sam4onnx) to rewrite variables and constants.
- [ ] By preparing a large number of ONNX files of a single OP as a component and rewriting them individually with sam4onnx to the necessary parameters, any combination of OPs can be generated like a puzzle.
- [ ] All generated single-OP ONNX files are combined with [snc4onnx](https://github.com/PINTO0309/snc4onnx).
- [ ] Use [sna4onnx](https://github.com/PINTO0309/sna4onnx) to add OPs to the generated ONNX graph and [snd4onnx](https://github.com/PINTO0309/snd4onnx) to remove OPs from the graph.
- [ ] The real goal of this repository is to componentize routine pre-processing and post-processing and directly replace the corresponding processing in various types of ONNX models, allowing for flexible switching between operations without modifying PyTorch or TensorFlow logic or re-exporting ONNX.

# Base
## As of April 28, 2022
https://github.com/onnx/onnx/blob/fb1f72159f4030ce45503279e6f6b8a7fb103e0f/docs/Operators.md#aionnx-default
