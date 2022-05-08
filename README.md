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

|**No.**|**Operator**|**Structure**|**Fin**|
|:-|:-|:-:|:-:|
|001|Abs||:heavy_check_mark:|
|002|Acos||:heavy_check_mark:|
|003|Acosh||:heavy_check_mark:|
|004|Add||:heavy_check_mark:|
|005|And||:heavy_check_mark:|
|006|ArgMax||:heavy_check_mark:|
|007|ArgMin||:heavy_check_mark:|
|008|Asin||:heavy_check_mark:|
|009|Asinh||:heavy_check_mark:|
|010|Atan|||
|011|Atanh|||
|012|AveragePool|||
|013|BatchNormalization|||
|014|BitShift|||
|015|Cast|||
|016|Ceil|||
|017|Clip|||
|018|Compress|||
|019|Concat|||
|020|ConcatFromSequence|||
|021|Constant|||
|022|ConstantOfShape|||
|023|Conv|||
|024|ConvInteger|||
|025|ConvTranspose|||
|026|Cos|||
|027|Cosh|||
|028|CumSum|||
|029|DepthToSpace|||
|030|DequantizeLinear|||
|031|Det|||
|032|Div|||
|033|Dropout|||
|034|Einsum|||
|035|Elu|||
|036|Equal|||
|037|Erf|||
|038|Exp|||
|039|Expand|||
|040|EyeLike|||
|041|Flatten|||
|042|Floor|||
|043|GRU|||
|044|Gather|||
|045|GatherElements|||
|046|GatherND|||
|047|Gemm|||
|048|GlobalAveragePool|||
|049|GlobalLpPool|||
|050|GlobalMaxPool|||
|051|Greater|||
|052|GridSample|||
|053|HardSigmoid|||
|054|Hardmax|||
|055|Identity|||
|056|If|||
|057|InstanceNormalization|||
|058|IsInf|||
|059|IsNaN|||
|060|LRN|||
|061|LSTM|||
|062|LeakyRelu|||
|063|Less|||
|064|Log|||
|065|Loop|||
|066|LpNormalization|||
|067|LpPool|||
|068|MatMul|||
|069|MatMulInteger|||
|070|Max|||
|071|MaxPool|||
|072|MaxRoiPool|||
|073|MaxUnpool|||
|074|Mean|||
|075|Min|||
|076|Mod|||
|077|Mul|||
|078|Multinomial|||
|079|Neg|||
|080|NonMaxSuppression|||
|081|NonZero|||
|082|Not|||
|083|OneHot|||
|084|Optional|||
|085|OptionalGetElement|||
|086|OptionalHasElement|||
|087|Or|||
|088|PRelu|||
|089|Pad|||
|090|Pow|||
|091|QLinearConv|||
|092|QLinearMatMul|||
|093|QuantizeLinear|||
|094|RNN|||
|095|RandomNormal|||
|096|RandomNormalLike|||
|097|RandomUniform|||
|098|RandomUniformLike|||
|099|Reciprocal|||
|100|ReduceL1|||
|101|ReduceL2|||
|102|ReduceLogSum|||
|103|ReduceLogSumExp|||
|104|ReduceMax|||
|105|ReduceMean|||
|106|ReduceMin|||
|107|ReduceProd|||
|108|ReduceSum|||
|109|ReduceSumSquare|||
|110|Relu|||
|111|Reshape|||
|112|Resize|||
|113|ReverseSequence|||
|114|RoiAlign|||
|115|Round|||
|116|Scan|||
|117|Scatter|||
|118|ScatterElements|||
|119|ScatterND|||
|120|Selu|||
|121|SequenceAt|||
|122|SequenceConstruct|||
|123|SequenceEmpty|||
|124|SequenceErase|||
|125|SequenceInsert|||
|126|SequenceLength|||
|127|Shape|||
|128|Shrink|||
|129|Sigmoid|||
|130|Sign|||
|131|Sin|||
|132|Sinh|||
|133|Size|||
|134|Slice|||
|135|Softplus|||
|136|Softsign|||
|137|SpaceToDepth|||
|138|Split|||
|139|SplitToSequence|||
|140|Sqrt|||
|141|Squeeze|||
|142|StringNormalizer|||
|143|Sub|||
|144|Sum|||
|145|Tan|||
|146|Tanh|||
|147|TfIdfVectorizer|||
|148|ThresholdedRelu|||
|149|Tile|||
|150|TopK|||
|151|Transpose|||
|152|Trilu|||
|153|Unique|||
|154|Unsqueeze|||
|155|Upsample|||
|156|Where|||
|157|Xor|||
|158|Bernoulli|||
|159|CastLike|||
|160|Celu|||
|161|DynamicQuantizeLinear|||
|162|GreaterOrEqual|||
|163|HardSwish|||
|164|LessOrEqual|||
|165|LogSoftmax|||
|166|MeanVarianceNormalization|||
|167|NegativeLogLikelihoodLoss|||
|168|Range|||
|169|SequenceMap|||
|170|Softmax|||
|171|SoftmaxCrossEntropyLoss|||
|Z001|Normalization_rgb_imagenet|![20220508222828](https://user-images.githubusercontent.com/33194443/167298468-9881994f-356d-4a2e-a1c0-ce7fb0d2de88.png)|:heavy_check_mark:|
|Z002|Normalization_bgr_imagenet|![20220508222945](https://user-images.githubusercontent.com/33194443/167298522-9acd3f1e-4249-4944-a3e8-7276c98eacd0.png)|:heavy_check_mark:|

</div></details>

# Reference
1. https://stackoverflow.com/questions/47344571/how-to-draw-checkbox-or-tick-mark-in-github-markdown-table
2. [Samples of handcrafting ONNX models (base64 encoding, base64 decoding, etc.)](https://zenn.dev/pinto0309/scraps/a15f4b5c941df3)
