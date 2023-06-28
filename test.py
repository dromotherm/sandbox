"""
ceci est un fichier de test
"""
import sys
import matplotlib.pyplot as plt
import numpy as np

print("hello planet earth !")

a = sys.argv[0]
print(a)


for arg in sys.argv:
    print(arg)

T = np.ones(500)*12

plt.subplot(111)
plt.plot(T)
plt.show()
plt.savefig("myfig")
