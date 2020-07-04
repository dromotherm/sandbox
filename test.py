print("hello")
import matplotlib.pyplot as plt
import numpy as np

T=np.ones(500)*12

plt.subplot(111)
plt.plot(T)
plt.show()
plt.savefig("myfig")
