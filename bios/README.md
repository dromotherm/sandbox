Télécharger la dernière raspios :

https://www.raspberrypi.org/software/operating-systems/#raspberry-pi-os-32-bit

Une fois l'image gravée :
```
cd /media/alexandrecuer/boot
touch ssh
cp cmdline.txt cmdline2.txt
nano cmdline.txt
sed -i "s~init=\/usr\/lib\/raspi-config\/init_resize.sh~~" cmdline.txt
```
On boote le Pi

étape 1 :
```
wget https://raw.githubusercontent.com/openenergymonitor/EmonScripts/master/install/init_resize.sh
chmod +x init_resize.sh
sudo mv init_resize.sh /usr/lib/raspi-config/init_resize.sh
sudo mv /boot/cmdline2.txt /boot/cmdline.txt
sudo reboot
```
étape 2 - redimensionnement de la carte SD :
```
sudo resize2fs /dev/mmcblk0p2
sudo mkfs.ext2 -b 1024 /dev/mmcblk0p3
sudo mkdir /var/opt/emoncms
sudo chown www-data /var/opt/emoncms
wget https://raw.githubusercontent.com/openenergymonitor/EmonScripts/master/defaults/etc/fstab
sudo cp fstab /etc/fstab
sudo reboot
```
On définit la bonne timezone : `sudo raspi-config`
```
cd /opt
sudo mkdir openenergymonitor
sudo chown pi:pi openenergymonitor
cd openenergymonitor
wget https://raw.githubusercontent.com/dromotherm/sandbox/master/makefile
make osupdate
```
On installe les dépendances :
```
make apache
make mysql
make php
make redis
make mosquitto
```
On installe le moteur :
```
make emoncms
make sudoers
make apacheconf
make feedwriter
make service-runner
make emoncms_mqtt
```
On installe les modules :
```
make module name=graph
make module name=dashboard
make symodule name=sync
make symodule name=postprocess
make symodule name=backup
```
on injecte les paramètres spécifiques pour la rotation des logs :
```
make custom_logrotate
make log2ram
```
