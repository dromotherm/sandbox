# le plus simple est de choisir lors de l'installation de la machine d'installer les logiciels tiers dont les pilotes additionnels propriétaires (eg nvidia)

```
ubuntu-drivers devices
vendor   : NVIDIA Corporation
model    : GA106 [GeForce RTX 3060 Lite Hash Rate]
driver   : nvidia-driver-550 - distro non-free recommended
driver   : nvidia-driver-535-server - distro non-free
driver   : nvidia-driver-535-open - distro non-free
driver   : nvidia-driver-535 - distro non-free
driver   : nvidia-driver-535-server-open - distro non-free
driver   : nvidia-driver-550-open - distro non-free
driver   : nvidia-driver-470-server - distro non-free
driver   : nvidia-driver-470 - distro non-free
driver   : xserver-xorg-video-nouveau - distro free builtin
```


https://phoenixnap.com/kb/install-nvidia-drivers-ubuntu

https://linuxconfig.org/how-to-install-the-nvidia-drivers-on-ubuntu-22-04


# if running on container -> NVIDIA Container Toolkit

https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

pour que celà soit pris en compte, il faut restarter l'ordinateur, mais relancer le docker daemon doit être suffisant : `sudo systemctl restart docker`


# GPU

https://askubuntu.com/questions/5417/how-to-get-the-gpu-info

la commande `lspci` détaille le matériel présent sur le PC notamment la carte graphique

# supervision de la mémoire GPU utilisée

## utilitaire nvidia-smi
il faut avoir installé les drivers cuda
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
for real time updates : `watch -n 1 nvidia-smi`

on peut avoir le retour suivant lorsqu'on lance la commande :
```
Failed to initialize NVML: Driver/library version mismatch
```
un reboot permet de revenir à la normale ?
https://stackoverflow.com/questions/43022843/nvidia-nvml-driver-library-version-mismatch

## nvtop

pour les amd64, nvtop est l'analogue de jtop pour les jetson. Utiliser jtop sur un amd ne donnera bien évidemment rien.

à installer via apt : `sudo apt-get install nvtop`

les sources : https://github.com/Syllo/nvtop.git

# installation des drivers cuda 

CUDA (an acronym for Compute Unified Device Architecture) is a parallel computing platform and application programming interface (API) model created by Nvidia.

## méthode nvidia

https://developer.nvidia.com/cuda-downloads

https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_local

https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#ubuntu-installation

```
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.4.1/local_installers/cuda-repo-ubuntu2004-11-4-local_11.4.1-470.57.02-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2004-11-4-local_11.4.1-470.57.02-1_amd64.deb
sudo apt-key add /var/cuda-repo-ubuntu2004-11-4-local/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda
```
En lançant l'utilitaire nvidia X server settings, on peut obtenir le nombre de coeurs de GPU disponibles
![image](https://user-images.githubusercontent.com/24553739/133930399-edbb0e44-d35d-485e-82a0-a80eca13dd9f.png)

On vient d'installer les cuda libraries. Il faut installer les cudaNN libraries : https://developer.nvidia.com/rdp/cudnn-download
```
sudo dpkg -i libcudnn8_8.2.4.15-1+cuda11.4_amd64.deb
```

vérifier que tf reconnait bien les gpu

```
python3
Python 3.8.10 (default, Jun  2 2021, 10:49:15) 
[GCC 9.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import tensorflow as tf
>>> tf.config.list_physical_devices("GPU")
2021-08-14 19:55:21.479232: I tensorflow/stream_executor/cuda/cuda_gpu_executor.cc:937] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero
2021-08-14 19:55:21.513437: I tensorflow/stream_executor/cuda/cuda_gpu_executor.cc:937] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero
2021-08-14 19:55:21.514109: I tensorflow/stream_executor/cuda/cuda_gpu_executor.cc:937] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero
[PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]
```
