https://developer.nvidia.com/buy-jetson?product=jetson_nano&location=FR

https://www.arrow.com/fr-fr/products/945-13450-0000-100/nvidia

https://www.sparkfun.com/products/16271

# enable sd card

https://wiki.seeedstudio.com/J101_Enable_SD_Card/

https://wiki.seeedstudio.com/J1010_Boot_From_SD_Card/

# softs

https://github.com/Qengineering/Jetson-Nano-Ubuntu-20-image

www.nvidia.com/JetsonNano

https://developer.nvidia.com/embedded/learn/get-started-jetson-nano-devkit#write



https://docs.nvidia.com/deeplearning/frameworks/index.html

# J101 board



https://fr.farnell.com/en-FR/seeed-studio/110061362/nvidia-jetson-nano-ref-carrier/dp/4126473?st=jetson#anchorTechnicalDOCS

https://www.seeedstudio.com/reComputer-J101-v2-Carrier-Board-for-Jetson-Nano-p-5396.html

https://files.seeedstudio.com/products/102991694/reComputer%20J101V2%20datasheet.pdf

https://files.seeedstudio.com/wiki/reComputer/reComputer-J101-PCBA-2D&3D.zip

# flashing the jetpack os to the 16Gb emmc memory

passer la carte en force recovery mode

https://wiki.seeedstudio.com/reComputer_J1010_J101_Flash_Jetpack/

Télécharger Driver Package (BSP) et Sample Root Filesystem :

```
Jetson-210_Linux_R32.7.3_aarch64.tbz2
Tegra_Linux_Sample-Root-Filesystem_R32.7.3_aarch64.tbz2
```
l'OS le plus à jour est sur https://developer.nvidia.com/embedded/jetson-linux mais pour la carte nano, il faut aller dans les archives :

https://developer.nvidia.com/embedded/jetson-linux-archive

https://developer.nvidia.com/embedded/linux-tegra-r3273

```
sudo apt-get install libxml2-utils
sudo apt-get install qemu-user-static
tar xf Jetson-210_Linux_R32.7.3_aarch64.tbz2
cd Linux_for_Tegra/rootfs/
sudo tar xpf ../../Tegra_Linux_Sample-Root-Filesystem_R32.7.3_aarch64.tbz2
sudo ./apply_binaries.sh
sudo ./flash.sh jetson-nano-devkit-emmc mmcblk0p1
```
Les 2 dernières lignes devraient être les suivantes :
```
*** The target t210ref has been flashed successfully. ***
Reset the board to boot from internal eMMC.
```

