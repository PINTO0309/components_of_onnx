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

# Progress

**<details><summary>Progress List</summary><div>**

|**No.**|**Operator**|**Fin**|
|:-|:-|:-:|
|1|Abs|:heavy_check_mark:|
|2|Acos|:heavy_check_mark:|
|3|Acosh|:heavy_check_mark:|
|4|Add|:heavy_check_mark:|
|5|And|:heavy_check_mark:|
|6|ArgMax|:heavy_check_mark:|
|7|ArgMin|:heavy_check_mark:|
|8|Asin|:heavy_check_mark:|
|9|Asinh|:heavy_check_mark:|
|10|Atan||
|11|Atanh||
|12|AveragePool||
|13|BatchNormalization||
|14|BitShift||
|15|Cast||
|16|Ceil||
|17|Clip||
|18|Compress||
|19|Concat||
|20|ConcatFromSequence||
|21|Constant||
|22|ConstantOfShape||
|23|Conv||
|24|ConvInteger||
|25|ConvTranspose||
|26|Cos||
|27|Cosh||
|28|CumSum||
|29|DepthToSpace||
|30|DequantizeLinear||
|31|Det||
|32|Div||
|33|Dropout||
|34|Einsum||
|35|Elu||
|36|Equal||
|37|Erf||
|38|Exp||
|39|Expand||
|40|EyeLike||
|41|Flatten||
|42|Floor||
|43|GRU||
|44|Gather||
|45|GatherElements||
|46|GatherND||
|47|Gemm||
|48|GlobalAveragePool||
|49|GlobalLpPool||
|50|GlobalMaxPool||
|51|Greater||
|52|GridSample||
|53|HardSigmoid||
|54|Hardmax||
|55|Identity||
|56|If||
|57|InstanceNormalization||
|58|IsInf||
|59|IsNaN||
|60|LRN||
|61|LSTM||
|62|LeakyRelu||
|63|Less||
|64|Log||
|65|Loop||
|66|LpNormalization||
|67|LpPool||
|68|MatMul||
|69|MatMulInteger||
|70|Max||
|71|MaxPool||
|72|MaxRoiPool||
|73|MaxUnpool||
|74|Mean||
|75|Min||
|76|Mod||
|77|Mul||
|78|Multinomial||
|79|Neg||
|80|NonMaxSuppression||
|81|NonZero||
|82|Not||
|83|OneHot||
|84|Optional||
|85|OptionalGetElement||
|86|OptionalHasElement||
|87|Or||
|88|PRelu||
|89|Pad||
|90|Pow||
|91|QLinearConv||
|92|QLinearMatMul||
|93|QuantizeLinear||
|94|RNN||
|95|RandomNormal||
|96|RandomNormalLike||
|97|RandomUniform||
|98|RandomUniformLike||
|99|Reciprocal||
|100|ReduceL1||
|101|ReduceL2||
|102|ReduceLogSum||
|103|ReduceLogSumExp||
|104|ReduceMax||
|105|ReduceMean||
|106|ReduceMin||
|107|ReduceProd||
|108|ReduceSum||
|109|ReduceSumSquare||
|110|Relu||
|111|Reshape||
|112|Resize||
|113|ReverseSequence||
|114|RoiAlign||
|115|Round||
|116|Scan||
|117|Scatter||
|118|ScatterElements||
|119|ScatterND||
|120|Selu||
|121|SequenceAt||
|122|SequenceConstruct||
|123|SequenceEmpty||
|124|SequenceErase||
|125|SequenceInsert||
|126|SequenceLength||
|127|Shape||
|128|Shrink||
|129|Sigmoid||
|130|Sign||
|131|Sin||
|132|Sinh||
|133|Size||
|134|Slice||
|135|Softplus||
|136|Softsign||
|137|SpaceToDepth||
|138|Split||
|139|SplitToSequence||
|140|Sqrt||
|141|Squeeze||
|142|StringNormalizer||
|143|Sub||
|144|Sum||
|145|Tan||
|146|Tanh||
|147|TfIdfVectorizer||
|148|ThresholdedRelu||
|149|Tile||
|150|TopK||
|151|Transpose||
|152|Trilu||
|153|Unique||
|154|Unsqueeze||
|155|Upsample||
|156|Where||
|157|Xor||
|158|Bernoulli||
|159|CastLike||
|160|Celu||
|161|DynamicQuantizeLinear||
|162|GreaterOrEqual||
|163|HardSwish||
|164|LessOrEqual||
|165|LogSoftmax||
|166|MeanVarianceNormalization||
|167|NegativeLogLikelihoodLoss||
|168|Range||
|169|SequenceMap||
|170|Softmax||
|171|SoftmaxCrossEntropyLoss||
|Z001|Normalization_rgb_imagenet||

</div></details>

# Reference
1. https://stackoverflow.com/questions/47344571/how-to-draw-checkbox-or-tick-mark-in-github-markdown-table
