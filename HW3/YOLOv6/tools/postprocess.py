import os
import json
import cv2
import argparse
import glob

parser = argparse.ArgumentParser()
parser.add_argument('--img_dir', default='../datasets/hw1_dataset/images/test',type=str)
parser.add_argument('--root_dir', default='./runs/inference/labels',type=str)
parser.add_argument('--save_path', type=str,default='pred.json')

arg = parser.parse_args()

if __name__ == "__main__":
    pred_list = {}

    for img_path in  glob.glob(os.path.join(arg.img_dir, '**/*.png'), recursive=True):
        rel_path = os.path.relpath(img_path, arg.img_dir)

        file_name = os.path.basename(img_path)[:-4]
        txt_path = os.path.join(arg.root_dir, file_name + '.txt')
        
        img = cv2.imread(img_path)
        height, width, _ = img.shape

        labels = []
        boxes = []
        scores = []
        with open(txt_path, 'r')as f:
            for line in f.readlines():
                line = list(map(float, line.split()))
                x = line[1]
                y = line[2]
                w = line[3]
                h = line[4]

                x_min, y_min = (x-w/2) * width, (y-h/2) * height
                x_max, y_max = (x+w/2) * width, (y+h/2) * height

                labels.append(int(line[0])+1)
                boxes.append([x_min, y_min, x_max, y_max])
                scores.append(line[5])

        pred = {}
        pred['labels'] = labels
        pred['boxes'] = boxes
        pred['scores'] = scores

        pred_list[rel_path] = pred
    print(f'Finish processed {len(pred_list)} images.')
    json_object = json.dumps(pred_list)
    os.makedirs(os.path.dirname(arg.save_path), exist_ok=True)
    with open(arg.save_path, 'w') as f:
        f.write(json_object)