cd YOLOv6
python3 tools/eval.py \
    --data data/dataset_org_with_fog.yaml \
    --weights weights/$1.pt \
    --task val \
    --device 0

cd ..