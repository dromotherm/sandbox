# BIOS

## Préparation SDcard

Télécharger la dernière raspios 

https://www.raspberrypi.org/software/operating-systems/#raspberry-pi-os-64-bit

si pas besoin de tensorflow full, seulement dispo sous 64 bits, utiliser les versions 32 bits, qui sont toujours recommandées

Prendre la lite version sans desktop

Les images les plus récentes sont compressées au format xz qui a un bien meilleur taux de compression que zip. Il faut installer les utilitaires.
```
sudo apt install xz-utils

xz -d -v 2022-04-04-raspios-bullseye-armhf-lite.img.xz
2022-04-04-raspios-bullseye-armhf-lite.img.xz (1/1)
  100 %     296,6 MiB / 1 924,0 MiB = 0,154    53 MiB/s       0:36
```

Graver sur SD avec [balena etcher download page](https://www.balena.io/etcher/)

Sur certaines ubuntu22, il manque libfuse2 et l'appimage d'etcher ne se lance pas `sudo apt install libfuse2`

**Avec les nouvelles images raspiOS, dès qu'on boote le PI, il faut avoir un écran et un clavier pour créer un utilisateur.**

Si on veut utiliser une distribution ubuntu : https://cdimage.ubuntu.com/releases/

### Activer le SSH

Uniquement si on utilise raspiOS, pas nécessaire sous Ubuntu :
```
cd /media/alexandrecuer/boot
touch ssh
```

### Repartionner avec gparted

C'est la solution la plus ergonomique pour organiser l'espace disque comme on le souhaite.
```
sudo gparted &
```
On redimensionne l'image qui contient le système et on utilise tout l'espace disque restant pour créer une nouvelle partition appelée datas en utilisant un système de fichier ext2

On boote le Pi

Pour vérifier que le partionnement s'est bien réalisé : `sudo parted -l`

## fstab
```
sudo mkdir /data
sudo chown $USER /data
```
on édite le fstab : `sudo nano /etc/fstab` pour qu'il ressemble à ceci :
```
proc            /proc           proc    defaults          0       0
PARTUUID=0a66e097-01  /boot/firmware  vfat    defaults          0       2
PARTUUID=0a66e097-02  /               ext4    defaults,noatime  0       1
PARTUUID=0a66e097-03  /data           ext2    defaults,noatime  0       2
# a swapfile is not a swap partition, no line here
#   use  dphys-swapfile swap[on|off]  for that
```
et on reboote :  `sudo reboot`

## Timezone

Si on est sous raspios : `sudo raspi-config`

Si on est sous Ubuntu, on commence par regarder la timezone :
```
timedatectl list-timezones | grep -i paris
Europe/Paris
ls -al /etc/localtime 
lrwxrwxrwx 1 root root 27 Apr 19 10:06 /etc/localtime -> /usr/share/zoneinfo/Etc/UTC
```
On met en place la nouvelle timezone :
```
sudo unlink /etc/localtime
sudo ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
```
Pour vérifier que la nouvelle timezone est bien prise en compte :
```
timedatectl
```

<details id=1>
<summary><h2>NodeRED</h2></summary>

Why not ?

```
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
sudo systemctl enable nodered.service
```

</details>

## install git and docker

```
sudo apt-get update
sudo apt-get install git
```

https://docs.docker.com/engine/install/debian/

check docker versions :

```
docker --version
docker compose version
```

## IO configuration

**You should have serial activated but not bluetooth !! otherwise, serial will not work**

serial console should also be desactivated.

To activate serial and desactivate serial console, use `sudo raspi-config`

For bluetooth, you have to modify config.txt, which is easy to access on a raspios

Previously in `/boot`, it is now in `/boot/firmware` :

```
sudo nano /boot/firmware/config.txt
```
add in the `[all]` section : `dtoverlay=disable-bt`

disable the bluetooth modem 
```
sudo systemctl disable hciuart
```
Once bluetooth disabled, `ls -al /dev/tty*` should show `/dev/ttyAMA0`

### troubles with USB on raspiOS 64 bits

Note on 17/03/2024 : added `dtoverlay=dwc2` just above the `[cm4]` section....

cf https://github.com/raspberrypi/firmware/issues/1804

having a lot of usb deconnections and this warning in journalctl 
```
WARN::dwc_otg_hcd_urb_dequeue:638: Timed out waiting for FSM NP transfer to complete on 2
```

<details id=5>
<summary><h2>phpredisadmin</h2></summary>

if you want a quick access to the redis database, without using redis-cli, you can use phpredisadmin :

```
sudo docker run -d --name=emoncms -p 8081:80 -p 7883:1883 -p 3001:3001 alexjunk/emoncms:alpine3.19_emoncms11.4.11
```
then :
```
sudo docker run -d --network=container:emoncms -e REDIS_1_HOST=127.0.0.1 -e PORT=3001 erikdubbelboer/phpredisadmin
```
stop the phpredisadmin container when you dont need any more, as there is no security 

</details>

## dans un boitier emonpi

Pour utiliser l'écran LCD : `sudo raspi-config` -> activer le bus I2C. 

Si vous avez cloné les sources de BIOS, aller dans le répertoire hardware en lancez la commande :
```
make install name=ihm2 user=root after_redis=0 after_mosquitto=0
```

## Configuration routeur

see also [reverse proxy](../nginx_reverse_proxy)

On connecte un pc configuré pour du DHCP au ***premier port du routeur (eth0)***, en filaire

On change le mot de passe du root

On peut fixer l'adresse du Pi à 192.168.1.2 en copiant sa mac depuis l'onglet DHCP

IP Pool de 192.168.1.3 à 192.168.1.254

### Wifi & wlan

On saisit un nom de ssid, qu'on choisit de diffuser (broadcast enabled) et on définit une clé wpa2-psk.

On active le wlan en gardant la configuration proposée (3.1)

### RS485

Si on a un bus RS485 promux à connecter au routeur, on injecte la library tcp2rtu.

Cette injection se fait par upload sans décompression d'un fichier tgz via le menu Customization -> User Module

On active le modbus TCP sur le port 2 (Enable MODBUS-TCP2RTU) sans changer quoi que soit.

### NAT

Configuration > NAT

On renseigne la translation d'adresse vers 192.168.1.2 sur le ports 443 (web) qu'utilisera le proxy nginx

On décoche les cases : 

- `Enable remote HTTP access on port 80` 
- `Enable remote HTTPS access on port 443`

**si on est en fonctionnement normal avec carte SIM, pour raison de sécurité, le port 22 doit être fermé !!**

### Configuration SMS

toujours dans Services, on configure la gestion via SMS (`Send SMS on connect to mobile network` et `Send SMS when datalimit is exceeded` cochées)

La gestion de la consommation de données s’effectue via la page Configuration > mobile WAN.

Il convient de cocher la case « enable trafic monitoring ». On choisit 8000 MB comme seuil et on choisit 60% comme niveau d'alerte.

