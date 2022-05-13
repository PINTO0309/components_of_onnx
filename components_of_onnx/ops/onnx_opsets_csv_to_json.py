import csv
import json
from itertools import islice
from collections import deque

data_row_start_num = 2

OPTYPE = 0
OPSET = 1
INPUTS = 2
OUTPUTS = 3
ATTRS = 4

ATTR_NAME = 0
ATTR_TYPE = 1
ATTR_DEFAULT = 2


def grps(l, gps, stp):
    d = deque(l)
    for i in range(0, len(l), stp):
        yield list(islice(d, gps))
        d.rotate(-stp)


def main():

    csv_file = open(
        "components_of_onnx/ops/onnx_opsets.csv",
        "r",
        encoding="utf_8",
    )
    fcsv = csv.reader(csv_file)

    onnx_opsets_json_dict = {}
    opset_dict = {}
    before_proc_op_type = ""

    for idx, data in enumerate(fcsv):
        # header skip
        if idx < data_row_start_num:
            continue

        if before_proc_op_type != data[OPTYPE]:
            if opset_dict:
                # optype
                onnx_opsets_json_dict[before_proc_op_type] = opset_dict
            before_proc_op_type = data[OPTYPE]
            opset_dict = {}

        # attributes
        ## attr x 10
        attr_range = data[ATTRS:]
        ## attr grouped list x 10
        attrs = list(grps(attr_range, 3, 3))
        attrs_dict = {}
        for attr in attrs:
            if attr[ATTR_NAME]:
                attrs_dict[attr[ATTR_NAME]] = [attr[ATTR_TYPE], attr[ATTR_DEFAULT]]

        input_output_attrs = {
            "inputs": data[INPUTS],
            "outputs": data[OUTPUTS],
            "attrs": attrs_dict,
        }

        # opset
        if not opset_dict:
            opset_dict = {
                data[OPSET]: input_output_attrs
            }
        else:
            opset_dict[data[OPSET]] = input_output_attrs

    if opset_dict:
        # optype
        onnx_opsets_json_dict[before_proc_op_type] = opset_dict
        opset_dict = {}

    with open('onnx_opsets.json', 'w') as fjson:
        json.dump(onnx_opsets_json_dict, fjson)

    print('Finish!')

if __name__ == '__main__':
    main()
