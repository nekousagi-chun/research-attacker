import matplotlib as plt
plt.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys

file_name = sys.argv[1]

data = np.loadtxt(file_name, delimiter=',', skiprows=1)

plt.title('Slow read test')
plt.xlabel('Time')
plt.ylabel('Connection')

Seconds = data[:,0]
Closed = data[:,1]
Pending = data[:,2]
Connected = data[:,3]
Service_Available = data[:,4]

plt.plot(Seconds, Closed, label='Closed')
plt.plot(Seconds, Pending, label='Pending')
plt.plot(Seconds, Connected, label='Connected')
plt.plot(Seconds, Service_Available, label='Service Available')


plt.legend(bbox_to_anchor=(1.05, 1), loc='upper left', borderaxespad=0, ncol=1)

img_name = file_name.rsplit('/')[-1].rsplit('.')[-2] + '.png'

plt.savefig(img_name, bbox_inches='tight')
