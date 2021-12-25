import onnx
from onnx import helper
from onnx import AttributeProto, TensorProto, GraphProto

parts_name = 'cast_float32_to_boolean'
tensor_shape = [None,None,None,None]


input = helper.make_tensor_value_info(
    name='input',
    elem_type=TensorProto.FLOAT,
    shape=tensor_shape
)
output = helper.make_tensor_value_info(
    name='output',
    elem_type=TensorProto.BOOL,
    shape=tensor_shape
)
node_def = helper.make_node(
    'Cast',
    ['input'],
    ['output'],
    parts_name,
    to=TensorProto.BOOL,
)
graph_def = helper.make_graph(
    [node_def],
    'test-model',
    [input],
    [output]
)
model_def = helper.make_model(
    graph_def,
    producer_name=parts_name
)
print('The model is:\n{}'.format(model_def))
onnx.checker.check_model(model_def)
print('The model is checked!')
onnx.save(model_def, f'{parts_name}.onnx')