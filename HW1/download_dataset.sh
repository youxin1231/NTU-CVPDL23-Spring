# Download pretrained model
if [ ! -f YOLOv6/weights/yolov6l6.pt ]; then
    mkdir YOLOv6/weights
    wget https://github.com/meituan/YOLOv6/releases/download/0.3.0/yolov6l6.pt
    mv yolov6l6.pt YOLOv6/weights
fi

if [ ! -f detr/checkpoints/detr-r50-e632da11.pth ]; then
    wget https://dl.fbaipublicfiles.com/detr/detr-r50-e632da11.pth
    mkdir detr/checkpoints && mv detr-r50-e632da11.pth detr/checkpoints
fi

if [ ! -d datasets ]; then
    gdown https://drive.google.com/uc?id=1SQxZ-68YwLrJQQbhyaMVghr-8ooYdfy9
    unzip hw1_data.zip
    rm hw1_data.zip

    mkdir datasets && mv hw1_dataset datasets

    mkdir -p datasets/hw1_dataset/images
    mkdir -p datasets/hw1_dataset/labels/train
    mkdir -p datasets/hw1_dataset/labels/valid

    mv datasets/hw1_dataset/train datasets/hw1_dataset/valid datasets/hw1_dataset/test datasets/hw1_dataset/images

    python3 YOLOv6/tools/preprocess.py
    rm dataset.yaml

    mkdir -p datasets/hw1_dataset/annotations
    mv datasets/hw1_dataset/images/train/_annotations.coco.json datasets/hw1_dataset/annotations/train.json
    mv datasets/hw1_dataset/images/valid/_annotations.coco.json datasets/hw1_dataset/annotations/valid.json

    mkdir -p datasets/coco_format/annotations
    cp datasets/hw1_dataset/annotations/train.json datasets/coco_format/annotations/instances_train2017.json
    cp datasets/hw1_dataset/annotations/valid.json datasets/coco_format/annotations/instances_val2017.json

    cp -r datasets/hw1_dataset/images/train datasets/coco_format/train2017
    cp -r datasets/hw1_dataset/images/valid datasets/coco_format/val2017
fi