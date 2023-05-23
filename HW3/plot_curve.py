import numpy as np
import matplotlib
import matplotlib.pyplot as plt
matplotlib.use('agg')

data = np.loadtxt('YOLOv6/runs/train/1/mAP50.txt', delimiter=',')

plt.plot(range(len(data)), data)

plt.title('mAP50 Curve')
plt.xlabel('Epoch')
plt.ylabel('mAP50')

plt.savefig('source_curve.png')
