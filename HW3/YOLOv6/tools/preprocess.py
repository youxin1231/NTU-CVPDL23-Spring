from pylabel import importer

for data in ['org/train', 'org/val', 'fog/val']:
    path_to_annotations = f'datasets/{data}.coco.json'
    path_to_label = 'datasets'
    dataset = importer.ImportCoco(path_to_annotations)
    dataset.export.ExportToYoloV5(path_to_label, './dataset.yaml', cat_id_index=0)