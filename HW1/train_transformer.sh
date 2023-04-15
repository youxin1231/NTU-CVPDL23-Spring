cd detr

python -m torch.distributed.launch \
    --nproc_per_node=1 \
    --use_env main.py \
    --coco_path ../datasets/coco_format \
    --output_dir output \
    --resume output/checkpoint.pth \
    
cd ..