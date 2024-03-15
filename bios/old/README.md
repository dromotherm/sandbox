# good to know even if most things are deprecated or done through the docker imaging process

## Prérequis sur un autre OS que Raspbian</h2></summary>

```
sudo echo $USER' ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/$USER && sudo chmod 0440 /etc/sudoers.d/$USER
```
nécessaire pour faire fonctionner sync


## Repartionner avec init_resize.sh

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

## Installation de emoncms/themis avec le makefile, avant le passage sous docker

**le makefile a été l'étape transitoire avant le dockerfile de 2023**
  
```
cd /opt
sudo mkdir openenergymonitor
sudo chown $(id -u -n):$(id -u -n) openenergymonitor
cd openenergymonitor
wget https://raw.githubusercontent.com/dromotherm/sandbox/master/makefile
```  
On met à jour la distribution
```
make osupdate
```
Si on veut utiliser log2ram (https://github.com/azlux/log2ram), il vaut mieux l'installer avant d'installer apache

```
make log2ram
```
On passe SIZE à 128Mo  `sudo nano /etc/log2ram.conf`

On reboote pour activer log2ram

Pour que l'installation du module backup ne pose pas de questions, on clone le repo EmonScripts
```
cd /opt/openenergymonitor
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
on change le nom de machine et le mot de passe du sudoer :
```
make customize
```
On reboote le PI

On installe le moteur :
```
cd /opt/openenergymonitor
make emoncms_www
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
### custom logrotate

```
make custom_logrotate
```

### Fix temporaires
L'interface admin d'emoncms utilise git pour récupérer les url et branches des dépôts

Hors des correctifs de sécurité font que git ne fait plus confiance aux dépôts par défaut

Pour contourner ce problème, comme on est sur une machine à utilisateur unique :
```
sudo git config --system --replace-all safe.directory '*'
```

### Installation de emonhub si on veut faire du monitoring électrique

```
cd /opt/openenergymonitor/EmonScripts/install
./emonhub.sh
cd /opt/openenergymonitor
make module name=config
```

### Installation de phpRedisAdmin si on veut une machine datalake éducative

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


## BIOS

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
```
Si on veut utiliser la v1.0.0 : `git checkout v1.0.0`

Pour installer les dépendances : `./requires.sh main`

Puis `./requires.sh python v2.9.0 tensorflow-2.9.0-cp39-none-linux_aarch64.whl` ou `./requires.sh python v2.9.0 tflite_runtime-2.9.0-cp39-none-linux_aarch64.whl` pour initialiser l'environnement virtuel `bios` dans `/opt/v` et y installer tous les packages pip nécessaires dont pymodbus et tensorflow. 

Tous les exécutables python de BIOS utilisent le shebang `#!/opt/v/bios/bin/python3`

L'installation de tensorflow sur arm se fait gràce à une wheel. Pour en savoir plus, [tensorflow sur arm](../tensorflow_on_arm.md)

[Tester que tensorflow fonctionne correctement](../../tensorflow/installOnRPI.md)

sur armv7l : `sudo apt-get install libatlas-base-dev`

pour installer une version spécifique de numpy (pas nécessaire mais bon pour la culture générale) `python3 -m pip install --force-reinstall numpy==1.23`

### [Ce qu'il se passe si on n'installe pas les dépendances](break.md)

### Installation du module pour emoncms

permet de visualiser les log des services liés à BIOS et de modifier les fichiers conf
```
cd /var/www/emoncms/Modules
git clone https://github.com/alexjunk/OBMmonitor
```

