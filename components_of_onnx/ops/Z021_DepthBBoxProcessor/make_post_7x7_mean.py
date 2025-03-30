import torch
import torch.nn as nn
import torch.nn.functional as F
import onnx
from onnxsim import simplify

class DepthBBoxProcessor(nn.Module):
    def __init__(self):
        super(DepthBBoxProcessor, self).__init__()

    def forward(self, bboxes: torch.Tensor, depth_map: torch.Tensor):
        """
        Args:
            bboxes (torch.Tensor): Tensor of shape [instances, 7] containing [batchid, classid, score, x1, y1, x2, y2].
            depth_map (torch.Tensor): Tensor of shape [batch, 1, Height, Width] representing pixel-wise depth.

        Returns:
            torch.Tensor: Tensor of shape [instances, 8] containing [batchid, classid, score, x1, y1, x2, y2, depth].
        """
        batch_ids = bboxes[:, 0].long()
        height, width = depth_map.shape[2], depth_map.shape[3]

        # 中心座標 (normalized [0, 1] -> [-1, 1] for grid_sample)
        cx = (bboxes[:, 3] + bboxes[:, 5]) / 2 * 2 - 1
        cy = (bboxes[:, 4] + bboxes[:, 6]) / 2 * 2 - 1

        # 7x7 grid offset
        offset_x = torch.linspace(-3, 3, steps=7, device=bboxes.device) / (width * 0.5)
        offset_y = torch.linspace(-3, 3, steps=7, device=bboxes.device) / (height * 0.5)
        grid_y, grid_x = torch.meshgrid(offset_y, offset_x, indexing='ij')  # [7, 7]
        grid_offsets = torch.stack([grid_x, grid_y], dim=-1).view(1, 7, 7, 2)  # [1, 7, 7, 2]

        # prepare output
        samples = []
        for i in range(bboxes.shape[0]):
            grid_center = torch.stack([cx[i], cy[i]], dim=0).view(1, 1, 1, 2)
            grid = (grid_center + grid_offsets).clamp(-1, 1)  # [1, 7, 7, 2]
            depth = F.grid_sample(depth_map[batch_ids[i]].unsqueeze(0), grid, align_corners=True)  # [1, 1, 7, 7]
            avg_depth = depth.mean().view(1)
            samples.append(avg_depth)

        sampled_depths = torch.stack(samples, dim=0)  # [N, 1]
        return torch.cat([bboxes, sampled_depths], dim=1)

# Example usage
if __name__ == "__main__":
    bboxes = torch.tensor([
        [0, 1, 0.9, 0.25, 0.25, 0.75, 0.75],
        [1, 2, 0.8, 0.15, 0.15, 0.5, 0.5]
    ], dtype=torch.float32)

    depth_map = torch.rand(2, 1, 200, 200)

    processor = DepthBBoxProcessor()
    updated_bboxes = processor(bboxes, depth_map)
    print(updated_bboxes)

    processor.cpu()
    processor.eval()
    bbox_depth_merge_onnx_file = f"bboxes_depth_merge_process.onnx"
    torch.onnx.export(
        processor,
        args=(bboxes, depth_map),
        f=bbox_depth_merge_onnx_file,
        opset_version=16,
        input_names=['input_bboxes', 'inuput_depth_map'],
        output_names=['batchno_classid_score_x1y1x2y2_depth'],
        dynamic_axes={
            'input_bboxes' : {0: 'N'},
            'inuput_depth_map' : {2: 'H', 3: 'W'},
            'batchno_classid_score_x1y1x2y2_depth' : {0: 'N'},
        }
    )
    model_onnx = onnx.load(bbox_depth_merge_onnx_file)
    model_simp, check = simplify(model_onnx)
    onnx.save(model_simp, bbox_depth_merge_onnx_file)