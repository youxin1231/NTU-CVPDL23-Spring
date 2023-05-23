# Download pretrained model
if [ ! -f YOLOv6/weights/yolov6l6.pt ]; then
    mkdir YOLOv6/weights
    wget https://github.com/meituan/YOLOv6/releases/download/0.3.0/yolov6l6.pt
    mv yolov6l6.pt YOLOv6/weights
fi

if [ ! -f hw3_data.zip ]; then
    gdown https://drive.google.com/uc?id=1suUT57y9nzol2dYh2lK9O_km7p7De4_M
fi

if [ ! -d datasets ]; then
    unzip -q hw3_data.zip

    mv hw3_dataset datasets

    python3 YOLOv6/tools/preprocess.py
    rm dataset.yaml

    # org datasets
    mkdir -p datasets/org/images
    mkdir -p datasets/org/annotations
    mkdir -p datasets/org/labels/train
    mkdir -p datasets/org/labels/val

    mv datasets/org/train/*.txt datasets/org/labels/train
    mv datasets/org/val/*.txt datasets/org/labels/val
    mv datasets/org/train datasets/org/val datasets/org/images

    mv datasets/org/train.coco.json datasets/org/annotations
    mv datasets/org/val.coco.json datasets/org/annotations

    # fog datasets
    mkdir -p datasets/fog/images
    mkdir -p datasets/fog/annotations
    mkdir -p datasets/fog/labels/train
    mkdir -p datasets/fog/labels/val
    
    mv datasets/fog/val/*.txt datasets/fog/labels/val
    mv datasets/fog/train datasets/fog/val datasets/fog/public_test datasets/fog/images
    
    mv datasets/fog/val.coco.json datasets/fog/annotations
fi