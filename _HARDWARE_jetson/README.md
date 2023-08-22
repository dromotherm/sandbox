https://pythops.com/post/create-your-own-image-for-jetson-nano-board

https://developer.nvidia.com/embedded/community/resources

https://developer.nvidia.com/buy-jetson?product=jetson_nano&location=FR

https://www.arrow.com/fr-fr/products/945-13450-0000-100/nvidia

https://www.sparkfun.com/products/16271

https://github.com/JetsonHacksNano

https://elinux.org/Jetson/General_debug

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
cd ..
sudo ./apply_binaries.sh
sudo ./flash.sh jetson-nano-devkit-emmc mmcblk0p1
```
Les 2 dernières lignes devraient être les suivantes :
```
*** The target t210ref has been flashed successfully. ***
Reset the board to boot from internal eMMC.
```
# checking the L4T release version
```
head -n 1 /etc/nv_tegra_release
# R32 (release), REVISION: 7.3, GCID: 31982016, BOARD: t210ref, EABI: aarch64, DATE: Tue Nov 22 17:30:08 UTC 2022
```
# jtop
```
sudo pip3 install -U jetson-stats
```

# do not upgrade kernel

cf https://forums.developer.nvidia.com/t/jetson-nano-custom-kernel-replaced-after-apt-upgrade/179399
```
dpkg -S /boot/Image
sudo apt-mark hold nvidia-l4t-kernel nvidia-l4t-kernel-dtbs nvidia-l4t-kernel-headers nvidia-l4t-bootloader
```

# free space

Si on manque de place :-)

https://collabnix.com/easy-way-to-free-up-jetson-nano-sd-card-disk-space-by-40%EF%BF%BC%EF%BF%BC/

# CH34x RS485 USB key

Les drivers usb fournis avec la distribution ubuntu18 (release tegra) de chez nvidia ne fonctionnent pas. Il faut donc les recompiler.

Tout ce qui suit a été testé avec python3.6.9

on commence par attibuer les droits à l'utilisateur courant :
```
sudo usermod -a -G dialout $USER
```
on reboote pour que les choses soient prises en compte par le système et on installe quelques packages
```
sudo apt-get install -y git build-essential python3-pip python3-dev
python3 -m pip install pip --upgrade
python3 -m pip install pyserial
```
on trouve les sources du driver ch341.ko içi :

http://www.wch-ic.com/search?t=all&q=CH34

http://www.wch-ic.com/downloads/CH341SER_LINUX_ZIP.html

file category	|file content	|version	|upload time
--|--|--|--
CH341SER_LINUX....	|Linux driver for USB to serial port, supports CH340 and CH341, supports 32/64-bit operating systems.	|1.6	|2023-03-16

une fois le code source décompacté, il faut remplacer la mention (à la fin du code) `ch341_tty_driver->name = "ttyCH341USB"` par `ch341_tty_driver->name = "ttyUSB"` pour assurer la compatibilité avec pyserial, puis on compile

```
cd driver
make
```
on teste que celà fonctionne en loadant le driver :
```
sudo modprobe usbserial
sudo rmmod ch341.ko
sudo insmod /path/to/CH341SER_LINUX/driver/ch341.ko
dmesg | tail -10
```

on vérifie que le port est reconnu :
```
python3 -m serial.tools.list_ports
/dev/ttyUSB0
1 ports found
cd /path/to/BIOS2/tests
python3 modbusFromScratch.py
[2, 3, 0, 0, 0, 2, 196, 56]
b'\x02\x03\x00\x00\x00\x02\xc48'
press a key
wrote 8 bytes on the serial port
[2, 3, 4, 7, 109, 128, 0, 56, 90]
crc correct
les données lues en hexa :
07
6d
80
00
les données lues sous la forme de registre(s)
chaque registre étant un entier 16 bits non signé
[1901, 32768]
124616704
```
Pour rendre les choses persistantes :
```
sudo cp /lib/modules/$(uname -r)/kernel/drivers/usb/serial/ch341.ko ~
sudo cp /path/to/CH341SER_LINUX/driver/ch341.ko /lib/modules/$(uname -r)/kernel/drivers/usb/serial/ch341.ko
sudo depmod -a
```

# enable sd card

https://wiki.seeedstudio.com/J101_Enable_SD_Card/

https://wiki.seeedstudio.com/J1010_Boot_From_SD_Card/

# softs

www.nvidia.com/JetsonNano

https://developer.nvidia.com/embedded/learn/get-started-jetson-nano-devkit#write

https://docs.nvidia.com/deeplearning/frameworks/index.html

# J101 board


https://fr.farnell.com/en-FR/seeed-studio/110061362/nvidia-jetson-nano-ref-carrier/dp/4126473?st=jetson#anchorTechnicalDOCS

https://www.seeedstudio.com/reComputer-J101-v2-Carrier-Board-for-Jetson-Nano-p-5396.html

https://files.seeedstudio.com/products/102991694/reComputer%20J101V2%20datasheet.pdf

https://files.seeedstudio.com/wiki/reComputer/reComputer-J101-PCBA-2D&3D.zip


# install ubuntu 20

https://qengineering.eu/install-ubuntu-20.04-on-jetson-nano.html

# gparted
```
sudo apt install gparted
```
# change filesystem on sdcard

On a monté la carte sd qui contenait un système qu'on n'était pas arrivé à faire fonctionner (impossible de booter depuis la carte SD) construit avec une image de chez Qengineering : 
https://github.com/Qengineering/Jetson-Nano-Ubuntu-20-image

On vérifie l'état des partitions. Il y pas mal de petites partitions sur mmcblk1, on les supprimera plus tard

```
lsblk
NAME         MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
loop0          7:0    0     4K  1 loop /snap/bare/5
loop1          7:1    0  49,1M  1 loop /snap/core18/2717
loop2          7:2    0 196,9M  1 loop /snap/gnome-3-34-1804/94
loop3          7:3    0  44,4M  1 loop /snap/snap-store/639
loop4          7:4    0  49,1M  1 loop /snap/core18/2724
loop5          7:5    0  46,4M  1 loop /snap/snapd/18940
loop6          7:6    0 197,6M  1 loop /snap/gnome-3-34-1804/75
loop7          7:7    0  59,1M  1 loop /snap/core20/1832
loop8          7:8    0  59,1M  1 loop /snap/core20/1856
loop9          7:9    0  43,2M  1 loop /snap/snapd/18363
loop10         7:10   0    16M  1 loop
mmcblk0      179:0    0  14,7G  0 disk
├─mmcblk0p1  179:1    0    14G  0 part /
├─mmcblk0p2  179:2    0     1M  0 part
├─mmcblk0p3  179:3    0     6M  0 part
├─mmcblk0p4  179:4    0    80K  0 part
├─mmcblk0p5  179:5    0    64M  0 part
├─mmcblk0p6  179:6    0     1M  0 part
├─mmcblk0p7  179:7    0     6M  0 part
├─mmcblk0p8  179:8    0    80K  0 part
├─mmcblk0p9  179:9    0    64M  0 part
├─mmcblk0p10 179:10   0   192K  0 part
├─mmcblk0p11 179:11   0   256K  0 part
├─mmcblk0p12 179:12   0    63M  0 part
├─mmcblk0p13 179:13   0   512K  0 part
├─mmcblk0p14 179:14   0   256K  0 part
├─mmcblk0p15 179:15   0   256K  0 part
├─mmcblk0p16 179:16   0   300M  0 part
└─mmcblk0p17 179:17   0 185,4M  0 part
mmcblk0boot0 179:32   0     4M  1 disk
mmcblk0boot1 179:64   0     4M  1 disk
mmcblk0rpmb  179:96   0     4M  0 disk
mmcblk1      179:128  0  29,7G  0 disk
├─mmcblk1p1  179:129  0  29,7G  0 part /media/pi/b1c100cd-cc74-4e7f-acb8-f0d34c931ee8
├─mmcblk1p2  179:130  0   128K  0 part
├─mmcblk1p3  179:131  0   448K  0 part
├─mmcblk1p4  179:132  0   576K  0 part
├─mmcblk1p5  179:133  0    64K  0 part
├─mmcblk1p6  179:134  0   192K  0 part
├─mmcblk1p7  179:135  0   384K  0 part
├─mmcblk1p8  179:136  0    64K  0 part
├─mmcblk1p9  179:137  0   448K  0 part
├─mmcblk1p10 179:138  0   448K  0 part
├─mmcblk1p11 179:139  0   768K  0 part
├─mmcblk1p12 179:140  0    64K  0 part
├─mmcblk1p13 179:141  0   192K  0 part
└─mmcblk1p14 179:142  0   128K  0 part
zram0        252:0    0 495,5M  0 disk [SWAP]
zram1        252:1    0 495,5M  0 disk [SWAP]
zram2        252:2    0 495,5M  0 disk [SWAP]
zram3        252:3    0 495,5M  0 disk [SWAP]
```
on démonte mmcblk1p1 et on le formate en ext2 car c'est sur cette partition qu'on mettra les données emoncms
```
sudo umount /dev/mmcblk1p1
sudo mkfs.ext2 -b 1024 /dev/mmcblk1p1
mke2fs 1.45.5 (07-Jan-2020)
/dev/mmcblk1p1 contains a ext4 file system
        last mounted on /media/pi/b1c100cd-cc74-4e7f-acb8-f0d34c931ee8 on Sun Apr 30 15:17:06 2023
Proceed anyway? (y,N) y
Discarding device blocks: done
Creating filesystem with 31152128 1k blocks and 1947136 inodes
Filesystem UUID: cb0bbd91-abf4-441a-b503-461a4cc79637
Superblock backups stored on blocks:
        8193, 24577, 40961, 57345, 73729, 204801, 221185, 401409, 663553,
        1024001, 1990657, 2809857, 5120001, 5971969, 17915905, 19668993,
        25600001

Allocating group tables: done
Writing inode tables: done
Writing superblocks and filesystem accounting information: done
```
# ménage sur mmcblk1

![Screenshot from 2023-04-30 15-39-43](https://user-images.githubusercontent.com/24553739/235355984-e7d1c251-f8c2-47fa-a182-3edf4735b1c5.png)
![Screenshot from 2023-04-30 15-41-10](https://user-images.githubusercontent.com/24553739/235356018-5a237250-d789-46fb-9ba3-3b6b01ba25d3.png)
on supprime une par une les petites partitions existantes sur mmcblk1 jusqu'à obtenir 15Mo de'espace libre
![Screenshot from 2023-04-30 15-42-20](https://user-images.githubusercontent.com/24553739/235356057-d14e5da5-0e56-47a4-b1cc-75a5c9b5a057.png)
on peut ensuite réintégrer cet espace libre dans mmcblk1p1 en utilisant gparted

# modification de /etc/fstab
```
sudo nano /etc/fstab

# /etc/fstab: static file system information.
#
# These are the filesystems that are always mounted on boot, you can
# override any of these by copying the appropriate line from this file into
# /etc/fstab and tweaking it as you see fit.  See fstab(5).
#
# <file system> <mount point>             <type>          <options>                               <dump> <pass>
/dev/root            /                     ext4           defaults                                     0 1
/dev/mmcblk1p1  /var/opt/emoncms   ext2    defaults,noatime,nodiratime  0  2
```
on monte /dev/mmcblk1p1
```
sudo mount /dev/mmcblk1p1
```
on vérifie
```
df -Th
Filesystem     Type      Size  Used Avail Use% Mounted on
/dev/mmcblk0p1 ext4       14G  8,0G  5,1G  61% /
none           devtmpfs  1,8G     0  1,8G   0% /dev
tmpfs          tmpfs     2,0G   92K  2,0G   1% /dev/shm
tmpfs          tmpfs     397M   13M  384M   4% /run
tmpfs          tmpfs     5,0M  4,0K  5,0M   1% /run/lock
tmpfs          tmpfs     2,0G     0  2,0G   0% /sys/fs/cgroup
/dev/loop0     squashfs  128K  128K     0 100% /snap/bare/5
/dev/loop1     squashfs   50M   50M     0 100% /snap/core18/2717
/dev/loop2     squashfs  197M  197M     0 100% /snap/gnome-3-34-1804/94
/dev/loop3     squashfs   45M   45M     0 100% /snap/snap-store/639
/dev/loop4     squashfs   50M   50M     0 100% /snap/core18/2724
/dev/loop5     squashfs   47M   47M     0 100% /snap/snapd/18940
/dev/loop6     squashfs  198M  198M     0 100% /snap/gnome-3-34-1804/75
/dev/loop7     squashfs   60M   60M     0 100% /snap/core20/1832
/dev/loop8     squashfs   60M   60M     0 100% /snap/core20/1856
/dev/loop9     squashfs   44M   44M     0 100% /snap/snapd/18363
tmpfs          tmpfs     397M   16K  397M   1% /run/user/120
tmpfs          tmpfs     397M   60K  397M   1% /run/user/1000
/dev/mmcblk1p1 ext2       30G  4,6M   28G   1% /var/opt/emoncms
```
