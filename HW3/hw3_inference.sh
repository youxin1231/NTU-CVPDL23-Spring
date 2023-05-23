cd YOLOv6
python3 tools/infer.py \
    --weights weights/$3.pt \
    --save-dir runs/inference/$3 \
    --source $1 \
    --save-txt \
    --not-save-img \
    --device 0

python3 tools/postprocess.py \
    --img_dir $1 \
    --save_path $2 \
    --root_dir ./runs/inference/$3/labels

cd ..