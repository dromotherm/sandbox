
# GPU

https://askubuntu.com/questions/5417/how-to-get-the-gpu-info

la commande `lspci` déatille le matériel présent sur le PC notamment la carte graphique

```
GPU=$(lspci | grep VGA | cut -d ":" -f3);RAM=$(cardid=$(lspci | grep VGA |cut -d " " -f1);lspci -v -s $cardid | grep " prefetchable"| cut -d "=" -f2);echo $GPU $RAM
```

# installation des drivers cuda 

https://www.tensorflow.org/install/gpu?hl=fr

```
nvidia-smi
Sat Aug 14 14:13:54 2021       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 450.142.00   Driver Version: 450.142.00   CUDA Version: 11.0     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  GeForce GTX 950M    On   | 00000000:01:00.0 Off |                  N/A |
| N/A   42C    P8    N/A /  N/A |      7MiB /  2004MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|    0   N/A  N/A      1226      G   /usr/lib/xorg/Xorg                  3MiB |
|    0   N/A  N/A      1781      G   /usr/lib/xorg/Xorg                  3MiB |
+-----------------------------------------------------------------------------+
```
