
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

**ON FAIT LA PREMIERE MISE A JOUR PROPOSEE AVANT DE DESINSTALLER LES APPLIS INUTILES**

# checking the L4T release version
```
head -n 1 /etc/nv_tegra_release
# R32 (release), REVISION: 7.3, GCID: 31982016, BOARD: t210ref, EABI: aarch64, DATE: Tue Nov 22 17:30:08 UTC 2022
```

# do not upgrade kernel

cf https://forums.developer.nvidia.com/t/jetson-nano-custom-kernel-replaced-after-apt-upgrade/179399
```
dpkg -S /boot/Image
sudo apt-mark hold nvidia-l4t-kernel nvidia-l4t-kernel-dtbs nvidia-l4t-kernel-headers nvidia-l4t-bootloader
```

# free space

Si on manque de place :-)

installer falkon a la place de chromium

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

une fois le code source décompacté, on ouvre le dossier driver et on édite le ficher `ch341.c`

Il faut remplacer la mention (à la fin du code) `ch341_tty_driver->name = "ttyCH341USB"` par `ch341_tty_driver->name = "ttyUSB1"` pour assurer la compatibilité avec pyserial. Le `1` sert à ce que le port modbus soit au moins `ttyUSB10`.

On peut à ce stade compiler par la commande `make`

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

`sudo /opt/nvidia/jetson-io/config-by-hardware.py -n "reComputer sdmmc"`

Dont do this : https://wiki.seeedstudio.com/J1010_Boot_From_SD_Card/

# install gparted

`sudo apt install gparted` and format sd as ext2 with `data` as volume name 

## install new fstab
```
sudo mkdir /data
sudo chown pi /data
wget https://raw.githubusercontent.com/dromotherm/sandbox/master/_HARDWARE_jetson/fstab
sudo cp fstab /etc/fstab
sudo reboot
```
# les logs

Pour gérer la taille et la rotation des logs, on crée un fichier `daemon.json` dans `/ect/docker` :
```
sudo apt-get install nano
nano /etc/docker/daemon.json
```
on y met le contenu suivant :
```
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "3m",
    "max-file": "3",
    "labels": "production_status",
    "env": "os,customer"
  }
}
```
Et on relance le docker daemon : `sudo systemctl restart docker`

quant on n'a pas nano :
```
cat << EOF > /etc/docker/daemon.json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "3m",
    "max-file": "3",
    "labels": "production_status",
    "env": "os,customer"
  }
}
EOF
```

Les logs sont dans `/var/lib/docker/containers`
