---
title: Themis/EmonCMS - Scripted Installation
sidebar: themis_sidebar
permalink: Themis_install.html
---

## prepare the SD card

### operating system

burn the lastest version of rapsbian (buster) with Etcher

[raspbian download page](https://www.raspberrypi.org/software/operating-systems/#raspberry-pi-os-32-bit)

Choose the [lite version](https://downloads.raspberrypi.org/raspbian_lite_latest) without desktop

[balena etcher download page](https://www.balena.io/etcher/)

### ssh access

Create an ssh file on the SD boot directory

On linux, if the SD boot directory is mounted on `/media/alexandrecuer/boot` :
```
cd /media/alexandrecuer/boot
touch ssh
```

On windows, if the SD boot directory is mounted on `E` :

```
echo.>E:\ssh
```
### disable (temporary) the automatic SD card resizing process 

Copy the default cmdline.txt to cmdline2.txt in the boot partition and then open to edit cmdline.txt, remove: `init=/usr/lib/raspi-config/init_resize.sh`
On linux :

```
cd /media/alexandrecuer/boot
cp cmdline.txt cmdline2.txt
nano cmdline.txt
```

## boot the RPI and adjust the file system, once logged in via SSH

We assume the rapsberry was assigned the IP address `192.168.1.23` by the network DHCP server.

To proceed to a SSH log in, as the user `pi`, via a linux workstation : `ssh pi@192.168.1.23` and enter the raspbian base password : `raspberry`

```
wget https://raw.githubusercontent.com/openenergymonitor/EmonScripts/master/install/init_resize.sh
chmod +x init_resize.sh
sudo mv init_resize.sh /usr/lib/raspi-config/init_resize.sh
sudo mv /boot/cmdline2.txt /boot/cmdline.txt
sudo reboot

sudo resize2fs /dev/mmcblk0p2
sudo mkfs.ext2 -b 1024 /dev/mmcblk0p3
sudo mkdir /var/opt/emoncms
sudo chown www-data /var/opt/emoncms
wget https://raw.githubusercontent.com/openenergymonitor/EmonScripts/master/defaults/etc/fstab
sudo cp fstab /etc/fstab
sudo reboot
```
Check resizing was successfully done : with `df -h` and a 16Gb sd card, the output should be :
```
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       4.2G  1.1G  3.0G  26% /
devtmpfs        460M     0  460M   0% /dev
tmpfs           464M     0  464M   0% /dev/shm
tmpfs           464M  6.2M  458M   2% /run
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
tmpfs           464M     0  464M   0% /sys/fs/cgroup
tmpfs           1.0M     0  1.0M   0% /var/tmp
tmpfs            30M     0   30M   0% /tmp
/dev/mmcblk0p3   11G  3.8M  9.6G   1% /var/opt/emoncms
/dev/mmcblk0p1   43M   22M   21M  51% /boot
tmpfs            93M     0   93M   0% /run/user/1000
```
with a 32Gb SANDISK sd card:
```
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        20G  1.3G   18G   7% /
devtmpfs        431M     0  431M   0% /dev
tmpfs           463M     0  463M   0% /dev/shm
tmpfs           463M  6.2M  457M   2% /run
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
tmpfs           463M     0  463M   0% /sys/fs/cgroup
tmpfs           1.0M     0  1.0M   0% /var/tmp
tmpfs           1.0M     0  1.0M   0% /var/lib/php/sessions
tmpfs            30M     0   30M   0% /tmp
/dev/mmcblk0p3  9.9G  3.8M  9.4G   1% /var/opt/emoncms
/dev/mmcblk0p1  253M   54M  199M  22% /boot
tmpfs            93M     0   93M   0% /run/user/1000
```

At this stage, you can use the `sudo raspi-config` command to fix the timezone, if you don't want to stay on the UTC London one

```
Current default time zone: 'Europe/Paris'
Local time is now:      Sun Jun 14 11:12:36 CEST 2020.
Universal Time is now:  Sun Jun 14 09:12:36 UTC 2020.
```

## install the themis softwares 

download the scripts

```
cd /opt
sudo mkdir openenergymonitor
sudo chown pi:pi openenergymonitor
sudo apt-get install git
cd openenergymonitor
git clone -b master https://github.com/openenergymonitor/EmonScripts
cd EmonScripts
cd install
./main.sh
```
**finally, the process asks to change the sudoer pi password**

## install NodeRED
DEPRECATED
```
bash <(curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered)
```
current command
```
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
```

To start nodered as a service: `sudo systemctl enable nodered.service`

[to secure nodered](https://nodered.org/docs/user-guide/runtime/securing-node-red#usernamepassword-based-authentication)


## Extra notes - to check in case of installation problems

If the process described above does not succeed in creating a new /dev/mmcblk0p3 partition, you can do it manually using gparted on a ubuntu desktop

Once things are done in gparted, you will still have to format and to fix the sector size to 1024 :

```
sudo mkfs.ext2 -b 1024 /dev/mmcblk0p3
sudo mkdir /var/opt/emoncms
sudo chown www-data /var/opt/emoncms
wget https://raw.githubusercontent.com/openenergymonitor/EmonScripts/master/defaults/etc/fstab
sudo cp fstab /etc/fstab
sudo reboot
```


it is good to know how to debug the LCD. There is some dependancies with python3 :

```
sudo apt-get install python3-smbus i2c-tools python3-rpi.gpio python3-pip redis-server  python3-gpiozero -y
pip3 install redis paho-mqtt xmltodict requests
```
Nota : never use sudo with pip or pip3

All files are in `/opt/openenergymonitor/emonpi/lcd`

You can test with `python3 emonPiLCD.py`

debug with `systemctl status emonPiLCD.service` and `journalctl -f -u emonPiLCD`


## miscellaneous

To remove the isc-dhcp server, if not needed
```
cd /etc/systemd/system
sudo ln -s /dev/null isc-dhcp-server.service
```
