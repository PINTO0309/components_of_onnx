# [WIP] components_of_onnx

https://github.com/onnx/onnx/blob/main/docs/Operators.md

https://github.com/PINTO0309/simple-onnx-processing-tools

<p align="center">
  <img src="https://user-images.githubusercontent.com/33194443/170163635-00a4d3c6-e65f-43f5-8b34-c2c02c87b804.png" />
</p>

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
- https://github.com/onnx/onnx/blob/fb1f72159f4030ce45503279e6f6b8a7fb103e0f/docs/Operators.md#aionnx-default

# Opsets List

- [onnx_opsets](https://docs.google.com/spreadsheets/d/1_iUaLC9AP8AtND715NLSTh-fDX4WHBkF_rZCj0vgDvY/edit?usp=sharing)
- [onnx_opsets.csv](https://github.com/PINTO0309/components_of_onnx/blob/main/components_of_onnx/ops/onnx_opsets.csv)
- [onnx_opsets.json](https://github.com/PINTO0309/components_of_onnx/blob/main/components_of_onnx/ops/onnx_opsets.json)
- [opsets csv to json converter](https://github.com/PINTO0309/components_of_onnx/blob/main/components_of_onnx/ops/onnx_opsets_csv_to_json.py)

# Progress

**<details><summary>Progress List</summary><div>**

|**No.**|**Operator**|**Structure**|**Fin**|
|:-|:-|:-:|:-:|
|001|Abs|![20220508224354](https://user-images.githubusercontent.com/33194443/167299079-377df6fe-44de-45b0-9233-5d4f7443869f.png)|:heavy_check_mark:|
|002|Acos|![20220508224520](https://user-images.githubusercontent.com/33194443/167299117-f829b879-cafa-4241-8132-2c13b5d1ef05.png)|:heavy_check_mark:|
|003|Acosh|![20220508224605](https://user-images.githubusercontent.com/33194443/167299137-7c5b5e94-b6f8-4197-a8c4-796468a61061.png)|:heavy_check_mark:|
|004|Add|![20220508224659](https://user-images.githubusercontent.com/33194443/167299173-17eaf956-6903-4fba-95d7-88d47ec833a1.png)|:heavy_check_mark:|
|005|And|![20220508224805](https://user-images.githubusercontent.com/33194443/167299245-6fa7fb3e-9ef0-472b-b351-5ad5cf111d1e.png)|:heavy_check_mark:|
|006|ArgMax|![20220508224902](https://user-images.githubusercontent.com/33194443/167299292-b2dc5da1-6075-4c9e-bbae-8c2df26c70fd.png)|:heavy_check_mark:|
|007|ArgMin|![20220508224941](https://user-images.githubusercontent.com/33194443/167299320-22920bdf-2481-4b7e-b35c-80247d11cb8c.png)|:heavy_check_mark:|
|008|Asin|![20220508225017](https://user-images.githubusercontent.com/33194443/167299344-fec02870-0d3a-48de-83c4-73cd7ed1b397.png)|:heavy_check_mark:|
|009|Asinh|![20220508225055](https://user-images.githubusercontent.com/33194443/167299374-1dfaeab6-ddb8-4b8f-ae0e-71e9ec8103dc.png)|:heavy_check_mark:|
|010|Atan|![image](https://user-images.githubusercontent.com/33194443/169282959-74993325-ceda-471f-b9a6-bcf162709c34.png)|:heavy_check_mark:|
|011|Atanh|![image](https://user-images.githubusercontent.com/33194443/169283679-f3244151-abab-448e-ab18-8603c37c9918.png)|:heavy_check_mark:|
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
|080|NonMaxSuppression|![20220508233013](https://user-images.githubusercontent.com/33194443/167301110-014feebb-2dae-4d09-98e7-85771d4fe2b7.png)|:heavy_check_mark:|
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
|112|Resize|![image](https://user-images.githubusercontent.com/33194443/210193246-fcd8886a-77bf-41d1-a794-4259387ca78f.png)|:heavy_check_mark:|
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
|Z003|SingleClass_NonMaxSupression|480x640|:heavy_check_mark:|
|Z004|YOLACT_Edge_NonMaxSupression|550x550<br>![image](https://user-images.githubusercontent.com/33194443/173093836-d086b0fc-6871-4ae7-8a5d-d01accd30df5.png)|:heavy_check_mark:|
|Z005|Resize_0.5x0.5|1x3xHxW->1x3x(Hx0.5)x(Wx0.5)<br>![image](https://user-images.githubusercontent.com/33194443/187466590-b438ec6a-ffc9-411f-962e-8e100c8b6abe.png)|:heavy_check_mark:|
|Z006|Resize_HxW|1x3xHxW->1x3x(Hx?)x(Wx?)<br>![image](https://user-images.githubusercontent.com/33194443/187466719-0e41a41e-e711-47a3-9088-6d90db8adc70.png)|:heavy_check_mark:|
|Z007|Myriad_workaround_NonMaxSuppression|![image](https://user-images.githubusercontent.com/33194443/190858662-843da794-cd46-428c-a9cc-c69e444673e6.png)|:heavy_check_mark:|
|Z008|TensorRT_compatible_N_batch_Resize|![image](https://user-images.githubusercontent.com/33194443/190913936-0bede0fa-6b12-4fb4-8c80-c11307da8cb0.png)|:heavy_check_mark:|
|Z009|Unity_Barracuda_compatible_GatherND|![image](https://user-images.githubusercontent.com/33194443/191983488-e44bc4f8-6c87-4ea5-a549-09f49a67021d.png)|:heavy_check_mark:|
|Z010|Unity_Barracuda_compatible_Split|![image](https://user-images.githubusercontent.com/33194443/191984394-df7e1af3-db9d-4bff-982d-2724a54e9b50.png)|:heavy_check_mark:|
|Z011|YOLACT_PostProcess|![image](https://user-images.githubusercontent.com/33194443/205486006-edfd7cdf-9fab-47ad-9e60-5fc579c240e4.png)|:heavy_check_mark:|
|Z012|DAMO-YOLO_PostProcess|![image](https://user-images.githubusercontent.com/33194443/206088632-56049aa7-777e-47eb-a01a-2570afb831b5.png)|:heavy_check_mark:|
|Z013|YOLO_General_PostProcess (anchor+NMS)|![image](https://user-images.githubusercontent.com/33194443/207273281-a076cec5-9ee3-4dc7-8aa6-5d540fad61b1.png)|:heavy_check_mark:|
|Z014|Inverse (com.microsoft)|![image](https://user-images.githubusercontent.com/33194443/210161293-81d8f5bf-009a-4893-95b3-b092b3857a77.png)|:heavy_check_mark:|
|Z015|MSELoss|![image](https://user-images.githubusercontent.com/33194443/215070824-57acb638-51db-46e8-b2b8-39ec4e0dbc4d.png)|:heavy_check_mark:|
|Z016|EfficientNMS_TRT|![image](https://github.com/PINTO0309/components_of_onnx/assets/33194443/6610eed9-ffd2-4eb3-b8bd-e803306cbd53)|:heavy_check_mark:|
|Z017|BatchedNMS_TRT|![image](https://github.com/PINTO0309/components_of_onnx/assets/33194443/694c7cef-98b7-4f7b-a2c6-9d817cd11351)|:heavy_check_mark:|
|Z018|AffineTransform|![image](https://github.com/PINTO0309/components_of_onnx/assets/33194443/a376a565-137f-4957-99e5-4148f32995b9)|:heavy_check_mark:|
|Z019|AffineGrid_4D (general purpose)||:heavy_check_mark:|
|Z020|WarpAffine_4D||:heavy_check_mark:|
|Z021|DepthBBoxProcessor|![image](https://github.com/user-attachments/assets/9df3b9bb-59e1-4598-9a31-6a86afb8b0ec)|:heavy_check_mark:|

</div></details>

# Reference
1. https://stackoverflow.com/questions/47344571/how-to-draw-checkbox-or-tick-mark-in-github-markdown-table
2. [Samples of handcrafting ONNX models (base64 encoding, base64 decoding, etc.)](https://zenn.dev/pinto0309/scraps/a15f4b5c941df3)
