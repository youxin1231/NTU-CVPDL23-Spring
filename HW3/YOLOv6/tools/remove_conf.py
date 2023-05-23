import os
import glob

if __name__ == "__main__":
    for file_path in  glob.glob(os.path.join('../datasets/fog/labels/train/*.txt')):
        lines = []
        with open(file_path, 'r') as file:
            for line in file:
                line = line.split(' ')[:-1]
                line = [str(round(float(x), 4)) for x in line]
                line = ' '.join(line) + '\n'
                lines.append(line)

        with open(file_path, 'w') as file:
            file.writelines(lines)