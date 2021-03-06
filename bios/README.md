# BIOS

## préparation de la carte SD

Télécharger la dernière raspios :

https://www.raspberrypi.org/software/operating-systems/#raspberry-pi-os-32-bit

Une fois l'image gravée :
```
cd /media/alexandrecuer/boot
touch ssh
cp cmdline.txt cmdline2.txt
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
On reboote pour activer log2ram

```
cd /opt/openenergymonitor
git clone http://github.com/alexjunk/BIOS
cd BIOS
./requires.sh
```
On peut à ce stade arrêter le Pi de préparation et enlever la carte SD

## configuration routeur - 1 = sans SIM

On démarre BIOS sans carte SD ds le raspberry

On connecte un pc configuré pour du DHCP au ***premier port du routeur (eth0)***, en filaire

On change le mot de passe du root

### Primary LAN

192.168.2.1 : adresse du routeur

DHCP Client : disabled

IP Pool de 192.168.2.2 à 192.168.2.254

On applique, ce qui coupe la connection. On peut relancer BIOS pour reprendre la configuration 

### secondary LAN & al

DHCP Client : enabled

default gateway : 192.168.1.1

la case "Enable dynamic DHCP leases" n'est pas cochée

**Cette configuration secondaire permet d'utiliser le second port éthernet à un réseau de type livebox, configuré en 192.168.1.1, ce qui est utile pour disposer d'un accès internet quant il n'y a pas de carte SIM dans le routeur** 

En utilisant l'adresse qui est attribuée par la box, on peut accéder à l'interface de management du routeur depuis un ordi connecté en WIFI à la box

Nota : quant on n'a pas de carte SIM dans le routeur, il faut aller dans Configuration > Mobile WAN, et décocher la case "create connection to mobile network". Sinon le routeur va chercher à établir une connection en permanence.

Si on a un troisième port ethernet, on peut laisser sa configuration inchangée (4.1)

### wifi & wlan

On saisit un nom de ssid, qu'on choisit de diffuser (broadcast enabled) et on définit une clé wpa2-psk.

On active le wlan en gardant la configuration proposée (3.1)

### bail fixe pour le raspberry sur 192.168.2.2

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

** si on est en fonctionnement normal avec carte SIM, pour raison de sécurité, le port 22 doit être fermé !!**

## configuration routeur - 2 = avec SIM

### configuration mobile

on insère la carte SIM et on active la connection mobile

### dyndns

Configuration > Services > DynDNS

on coche la case "Enable DynDNS Client"

on renseigne le Hostname (eg : dromotherm.ddns.net) et dans le champ serveur, on saisit : `dynupdate.no-ip.com`

### configuration SMS

toujours dans Services, on configure la gestion via SMS (`Send SMS on connect to mobile network` et `Send SMS when datalimit is exceeded` cochées)

La gestion de la consommation de données s’effectue via la page Configuration > mobile WAN.

Il convient de cocher la case « enable trafic monitoring ». On choisit 8000 MB comme seuil et on choisit 60% comme niveau d'alerte.
