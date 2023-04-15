cd YOLOv6
rm -rf runs/val
python3 tools/eval.py \
--data data/dataset.yaml \
--weights runs/train/exp/weights/best_ckpt.pt \
--task val \
--device 0 \

cd ..