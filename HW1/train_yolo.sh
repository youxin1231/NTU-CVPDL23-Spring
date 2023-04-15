if [ ! -d datasets ]; then
    bash download_dataset.sh
fi
cd YOLOv6
python3 tools/train.py \
    --batch 2 \
    --conf configs/yolov6l6_finetune.py \
    --data data/dataset.yaml \
    --device 0 \

cd ..