from pylabel import importer

for data in ['train', 'valid']:
    path_to_annotations = 'datasets/hw1_dataset/images/' + data + '/_annotations.coco.json'
    path_to_label = 'datasets/hw1_dataset/labels/' + data
    dataset = importer.ImportCoco(path_to_annotations)
    dataset.export.ExportToYoloV5(path_to_label, '../../../dataset.yaml', cat_id_index=0)