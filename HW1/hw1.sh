cd YOLOv6
rm -rf runs/inference
python3 tools/infer.py \
    --weights runs/train/exp/weights/best_ckpt.pt \
    --source ../$1 \
    --device 0 \
    --save-txt \
    --save-dir runs/inference \
    --not-save-img \

python3 tools/postprocess.py \
    --img_dir ../$1 \
    --save_path ../$2 \

cd ..