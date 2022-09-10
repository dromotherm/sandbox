# BIOS

<details id=1>
<summary><h2>Prérequis sur x86</h2></summary>

__étape non nécessaire sur plateforme ARM de type raspberry__

```
sudo echo $USER' ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/$USER && sudo chmod 0440 /etc/sudoers.d/$USER
```
si on n'applique pas cette modification sur X86, sync ne fonctionnera pas
</details>


<details id=2>
<summary><h2>Préparation SDcard</h2></summary>

Télécharger la dernière raspios (ne plus utiliser les versions 32 bits) :

https://www.raspberrypi.org/software/operating-systems/#raspberry-pi-os-64-bit

Prendre la lite version sans desktop

Les images les plus récentes sont compressées au format xz qui a un bien meilleur taux de compression que zip. Il faut installer les utilitaires.
```
sudo apt install xz-utils

xz -d -v 2022-04-04-raspios-bullseye-armhf-lite.img.xz
2022-04-04-raspios-bullseye-armhf-lite.img.xz (1/1)
  100 %     296,6 MiB / 1 924,0 MiB = 0,154    53 MiB/s       0:36
```

Graver sur SD avec [balena etcher download page](https://www.balena.io/etcher/)

Avec les nouvelles images raspiOS, dès qu'on boote le PI, il faut avoir un écran et un clavier pour créer un utilisateur, prendre `pi` et `raspberry` puisque les choses sont changées en suivant. 

Si on veut utiliser une distribution ubuntu : https://cdimage.ubuntu.com/releases/

### Activer le SSH

Uniquement si on utilise raspiOS, pas nécessaire sous Ubuntu :
```
cd /media/alexandrecuer/boot
touch ssh
```

### Repartionner - solution 1 : gparted

C'est la solution la plus ergonomique pour organiser l'espace disque comme on le souhaite.
```
sudo gparted &
```
On redimensionne l'image qui contient le système et on utilise tout l'espace disque restant pour créer une nouvelle partition appelée datas en utilisant un système de fichier ext2

On boote le Pi

Pour vérifier que le partionnement s'est bien réalisé : `sudo parted -l`

### Repartionner - solution 2 : utiliser init_resize.sh

```
cd /media/alexandrecuer/boot
cp cmdline.txt cmdline2.txt
sed -i "s~init=\/usr\/lib\/raspi-config\/init_resize.sh~~" cmdline.txt
```
On boote le Pi :
```
wget https://raw.githubusercontent.com/openenergymonitor/EmonScripts/master/install/init_resize.sh
chmod +x init_resize.sh
sudo mv init_resize.sh /usr/lib/raspi-config/init_resize.sh
sudo mv /boot/cmdline2.txt /boot/cmdline.txt
sudo reboot
```
init_resize.sh uptodate par rapport à l'officiel - cf https://github.com/RPi-Distro/raspi-config/blob/master/usr/lib/raspi-config/init_resize.sh
```
https://raw.githubusercontent.com/alexandrecuer/EmonScripts/init_resize/install/init_resize.sh
```
On redimensionne la carte SD :
```
sudo resize2fs /dev/mmcblk0p2
sudo mkfs.ext2 -b 1024 /dev/mmcblk0p3
```
</details>

<details id=3>
<summary><h2>Montage des systèmes de fichiers avec la mise en place d'un nouveau fstab</h2></summary>

```
sudo mkdir /var/opt/emoncms
sudo chown www-data /var/opt/emoncms
wget https://raw.githubusercontent.com/openenergymonitor/EmonScripts/master/defaults/etc/fstab
sudo cp fstab /etc/fstab
sudo reboot
```
</details>

<details id=4>
<summary><h2>Timezone</h2></summary>

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
</details>

<details id=5>
<summary><h2>Installation</h2></summary>
  
```
cd /opt
sudo mkdir openenergymonitor
sudo chown $(id -u -n):$(id -u -n) openenergymonitor
cd openenergymonitor
wget https://raw.githubusercontent.com/dromotherm/sandbox/master/makefile
```  
**Si pas de prise en compte des drivers MOXA**
```
make osupdate
```
**Si prise en compte des drivers MOXA**
```
sudo apt-get update
sudo apt install git bc bison flex libssl-dev
sudo apt-get install raspberrypi-kernel-headers
sudo apt-get install -y git build-essential python3-pip python3-dev
wget https://raw.githubusercontent.com/dromotherm/sandbox/master/ZZ_MOXA/driv_linux_uport1p_v5.1.5_build_22053114.tgz
tar -xvf driv_linux_uport1p_v5.1.5_build_22053114.tgz
cd ./mxu11x0/
sudo ./mxinstall
```

Pour que l'installation du module backup ne pose pas de questions, on clone le repo EmonScripts
```
git clone https://github.com/openenergymonitor/EmonScripts
cp EmonScripts/install/emonsd.config.ini EmonScripts/install/config.ini
```

On installe les dépendances :
```
make apache
make mysql
make php
make redis
make mosquitto
```
On passe redis-py en package global (review)

```
export PV=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
export RV=$(pip3 show redis | grep -oP "\Version:\s+\K.*")
sudo mv /home/$(id -u -n)/.local/lib/python$PV/site-packages/redis /usr/lib/python3/dist-packages/redis
sudo mv /home/$(id -u -n)/.local/lib/python$PV/site-packages/redis-$RV.dist-info /usr/lib/python3/dist-packages/redis-$RV.dist-info
```

on change le nom de machine et le mot de passe du sudoer :
```
make customize
```
On reboote le PI

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
</details>

<details id=6>
<summary><h2>Installation de emonhub si on veut faire du monitoring électrique</h2></summary>
  
```
cd /opt/openenergymonitor/EmonScripts/install
./emonhub.sh
cd /opt/openenergymonitor
make module name=config
```
</details>

<details id=7>
<summary><h2>Installation de phpRedisAdmin si on veut une machine datalake éducative</h2></summary>

```
cd /opt/openenergymonitor
make phpRedisAdmin
```
dans ce cas, il convient de sécuriser un minimum :
```
nano phpRedisAdmin/includes/config.sample.inc.php
```
on décommente la section login et on choisit un mot de passe pour admin

</details>

<details id=8>
<summary><h2>Mise en ram des log</h2></summary>

on injecte les paramètres spécifiques pour la rotation des logs :
```
make custom_logrotate
make log2ram
```
On reboote pour activer log2ram

### [Difficultés avec log2ram](log2ram.md)

pour trouver ce qui occupe l'espace dans les log :
```
sudo du -a /var/log/* | sort -n -r | head -n 30
```
</details>

<details id=9>
<summary><h2>NodeRED</h2></summary>

```
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
sudo systemctl enable nodered.service
```

</details>

<details id=10>
<summary><h2>BIOS</h2></summary>

On passe sur la branche BIOS d'emoncms :
```
cd /var/www/emoncms
git remote set-url origin https://github.com/alexandrecuer/emoncms.git
git pull
git checkout bios_master
```
### Installation des dépendances
```
cd /opt/openenergymonitor
git clone http://github.com/alexjunk/BIOS2
cd BIOS2
./requires.sh
```
### Tensorflow
Si on est sur plateforme arm (raspberry), il faut installer tensorflow manuellement. `./required.sh` ne prend en charge l'installation de tensorflow que sur x86.

```
cd /var/opt/emoncms
sudo mkdir test
sudo chown $(id -u -n):$(id -u -n) test
cd test
```

v2.1.0 pour buster 32 bits
```
export RELEASE=v2.1.0
export TF=tensorflow-2.1.0-cp37-none-linux_armv7l.whl
```
v2.4.0rc2 pour buster 32 bits
```
export RELEASE=v2.4.0rc2
export TF=tensorflow-2.4.0rc2-cp37-none-linux_armv7l.whl
```
v2.9.0 pour bullseye 64 bits :
```
export RELEASE=v2.9.0
export TF=tensorflow-2.9.0-cp39-none-linux_aarch64.whl
```
on télécharge la wheel et on l'installe avec pip
```
wget https://github.com/dromotherm/sandbox/releases/download/$RELEASE/$TF
TMPDIR=/var/opt/emoncms/test python3 -m pip install --upgrade --no-cache-dir --upgrade $TF
```

un repo avec plus de wheels, dont des versions lite plus légères : https://github.com/PINTO0309/Tensorflow-bin

https://qengineering.eu/

pas besoin de TMPDIR avec les versions lite.....

[Tester que tensorflow fonctionne correctement](..+/tensorflow/installOnRPI.md#suites)

### [Ce qu'il se passe si on n'installe pas les dépendances](break.md)

### Installation du module pour emoncms

permet de visualiser les log des services liés à BIOS et de modifier les fichiers conf
```
cd /var/www/emoncms/Modules
git clone https://github.com/alexjunk/OBMmonitor
```
</details>

<details id=11>
<summary><h2>Si on compte utiliser la carte dans un boitier emonpi</h2></summary>

```
nano /opt/openenergymonitor/BIOS2/hardware/ihm.py
```
on modifie l'adresse du lcd et le pin du bouton de commande :

```
i2c_address = 0x27
gpiobutton = 23
```
Dans le run(), on remplace la ligne  :
```
push_btn = Button(gpiobutton, hold_time=5)
```
par :
```
push_btn = Button(gpiobutton, pull_up=False, hold_time=5)
```

</details>

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
