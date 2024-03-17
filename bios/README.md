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

## Configuration routeur - 1 = sans SIM

On démarre BIOS sans carte SD ds le raspberry

On connecte un pc configuré pour du DHCP au ***premier port du routeur (eth0)***, en filaire

On change le mot de passe du root

### Primary LAN

192.168.2.1 : adresse du routeur

DHCP Client : disabled

IP Pool de 192.168.2.2 à 192.168.2.254

On applique, ce qui coupe la connection. On peut relancer BIOS pour reprendre la configuration 

### Secondary LAN & al

DHCP Client : enabled

default gateway : 192.168.1.1

la case "Enable dynamic DHCP leases" n'est pas cochée

**Cette configuration secondaire permet de connnecter le second port éthernet à un réseau de type livebox, configuré en 192.168.1.1, ce qui est utile pour disposer d'un accès internet quant il n'y a pas de carte SIM dans le routeur** 

En utilisant l'adresse qui est attribuée par la box, on peut accéder à l'interface de management du routeur depuis un ordi connecté en WIFI à la box

Nota : quant on n'a pas de carte SIM dans le routeur, il faut aller dans Configuration > Mobile WAN, et décocher la case "create connection to mobile network". Sinon le routeur va chercher à établir une connection en permanence.

Si on a un troisième port ethernet, on peut laisser sa configuration inchangée (4.1)

### Wifi & wlan

On saisit un nom de ssid, qu'on choisit de diffuser (broadcast enabled) et on définit une clé wpa2-psk.

On active le wlan en gardant la configuration proposée (3.1)

### Bail fixe pour le raspberry sur 192.168.2.2

A ce stade, on peut éteindre BIOS, insérer la carte SD dans le raspberry et tt rallumer

On peut alors fixer l'adresse du Pi en copiant sa mac depuis l'onglet DHCP

IP Pool de 192.168.2.3 à 192.168.2.254

### RS485

Si on a un bus RS485 promux à connecter au routeur, on injecte la library tcp2rtu.

Cette injection se fait par upload sans décompression d'un fichier tgz via le menu Customization -> User Module

On active le modbus TCP sur le port 2 (Enable MODBUS-TCP2RTU) sans changer quoi que soit.

### NAT - provisoire

Configuration > NAT

On renseigne la translation d'adresse vers 192.168.2.2 sur le ports 80 (web)

On coche les cases : 

- `Enable remote HTTP access on port 80` 
- `Enable remote HTTPS access on port 443`

Nota : si le routeur n'a pas de wifi, si on est sans carte SIM et qu'on va rester sur un réseau de type livebox, il faut renseigner la translation d'adresse sur le port 22 pour faire du SSH depuis le réseau livebox

**si on est en fonctionnement normal avec carte SIM, pour raison de sécurité, le port 22 doit être fermé !!**

## Configuration routeur - 2 = avec SIM

### Configuration mobile

on insère la carte SIM et on active la connection mobile

### DNS dynamique

Configuration > Services > DynDNS

on coche la case "Enable DynDNS Client"

on renseigne le Hostname (eg : dromotherm.ddns.net) et dans le champ serveur, on saisit : `dynupdate.no-ip.com`

### Configuration SMS

toujours dans Services, on configure la gestion via SMS (`Send SMS on connect to mobile network` et `Send SMS when datalimit is exceeded` cochées)

La gestion de la consommation de données s’effectue via la page Configuration > mobile WAN.

Il convient de cocher la case « enable trafic monitoring ». On choisit 8000 MB comme seuil et on choisit 60% comme niveau d'alerte.
