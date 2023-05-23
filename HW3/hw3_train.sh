if [ ! -d datasets ]; then
    bash hw3_download_dataset.sh
fi

cd YOLOv6

if [ ! -f runs/train/0/weights/best_ckpt.pt ]; then
    python3 tools/train.py \
        --batch-size 2 \
        --img-size 2048 \
        --conf-file ./configs/yolov6l6_finetune.py \
        --data-path ./data/dataset_org.yaml \
        --name 0 \
        --device 0
fi

cp runs/train/0/weights/best_ckpt.pt weights/0.pt

cd  ..

if [ ! -d datasets/org_with_fog ]; then
    
    # org_with_fog datasets
    mkdir -p datasets/org_with_fog/images/train
    mkdir -p datasets/org_with_fog/images/val
    mkdir -p datasets/org_with_fog/labels/train
    mkdir -p datasets/org_with_fog/labels/val

    cd YOLOv6

    python3 tools/infer.py \
        --weights weights/0.pt \
        --source ../datasets/fog/images/train \
        --device 0 \
        --save-txt \
        --save-dir ../datasets/fog/labels/train \
        --conf-thres 0.2 \
        --iou-thres 0.45 \
        --not-save-img

    mv ../datasets/fog/labels/train/labels/* ../datasets/fog/labels/train/
    rmdir ../datasets/fog/labels/train/labels
    python3 tools/remove_conf.py
    
    cd ..
    
    cd datasets/org/images/train
    for f in *; do cp "$f" "../../../org_with_fog/images/train/org_$f"; done
    cd ../../../..


    cd datasets/org/labels/train
    for f in *; do cp "$f" "../../../org_with_fog/labels/train/org_$f"; done
    cd ../../../..


    cd datasets/fog/images/train
    for f in *; do cp "$f" "../../../org_with_fog/images/train/fog_$f"; done
    cd ../../../..

    cd datasets/fog/labels/train
    for f in *; do cp "$f" "../../../org_with_fog/labels/train/fog_$f"; done
    cd ../../../..


    # cd datasets/org_with_fog/images/train
    # ls -v | cat -n | while read n f; do mv -n "$f" "$n.png"; done
    # cd ../../../..

    # cd datasets/org_with_fog/labels/train
    # ls -v | cat -n | while read n f; do mv -n "$f" "$n.txt"; done
    # cd ../../../..

    cp -r datasets/fog/images/val datasets/org_with_fog/images/
    cp -r datasets/fog/labels/val datasets/org_with_fog/labels/
fi

cd YOLOv6

if [ ! -f runs/train/1/weights/best_ckpt.pt ]; then
    python3 tools/train.py \
        --data-path ./data/dataset_org_with_fog.yaml \
        --conf-file ./configs/yolov6l6_self_training.py \
        --img-size 2048 \
        --batch-size 2 \
        --epochs 50 \
        --name 1 \
        --device 0
fi

cp runs/train/1/weights/1.pt weights
cp runs/train/1/weights/2.pt weights
cp runs/train/1/weights/3.pt weights
cp runs/train/1/weights/best_ckpt.pt weights/4.pt

cd ..