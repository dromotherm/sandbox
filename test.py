print("hello")
import matplotlib.pyplot as plt
import numpy as np
import sys

a=sys.argv[0]
print(a)

for arg in sys.argv:
    print(arg)

T=np.ones(500)*12

plt.subplot(111)
plt.plot(T)
plt.show()
plt.savefig("myfig")
