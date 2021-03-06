Bof pour le changement d'emplacement d'emoncms core : autant continuer à l'installer dans /var/www

Par contre, celà pourrait être intéressant d'avoir un makefile qui installe les choses, plus que tout un ensemble complexe de fichiers bash

on ferait : make apache, make redis....


## Apache

```
sudo apt-get update -y
sudo apt-get upgrade
sudo apt-get install -y apache2 gettext
sudo apt-get install -y php
wget https://raw.githubusercontent.com/openenergymonitor/EmonScripts/master/install/mysql.sh
wget https://raw.githubusercontent.com/openenergymonitor/EmonScripts/master/install/load_config.sh
chmod +x mysql.sh
sudo apt install curl
curl https://raw.githubusercontent.com/openenergymonitor/EmonScripts/master/install/emonsd.config.ini -o config.ini
./mysql.sh
sudo apt-get install -y php-mysql
sudo a2enmod rewrite
```
```
cd /opt
sudo mkdir openenergymonitor
sudo chown ludivine openenergymonitor/
cd openenergymonitor/
git clone http://github.com/emoncms/emoncms.git
```

```
cd ~
wget https://raw.githubusercontent.com/dromotherm/sandbox/master/conf_files/newUbuntuForDataWork/000-default.conf
sudo cp 000-default.conf /etc/apache2/sites-available/000-default.conf
wget https://raw.githubusercontent.com/dromotherm/sandbox/master/conf_files/newUbuntuForDataWork/service-runner.service
cp service-runner.service /opt/openenergymonitor/emoncms/scripts/services/service-runner/service-runner.service
wget https://raw.githubusercontent.com/dromotherm/sandbox/master/conf_files/newUbuntuForDataWork/feedwriter.service
cp feedwriter.service /opt/openenergymonitor/emoncms/scripts/services/feedwriter/feedwriter.service
```

```
sudo mkdir /var/log/emoncms
sudo touch /var/log/emoncms/emoncms.log
sudo chmod 666 /var/log/emoncms/emoncms.log
cd /opt/openenergymonitor/emoncms
curl https://raw.githubusercontent.com/openenergymonitor/EmonScripts/master/defaults/emoncms/emonpi.settings.ini -o settings.ini
nano settings.ini
```
On change un certain nombre de chemins :
```
emoncms_dir = "/opt/emoncms"
openenergymonitor_dir = "/opt/openenergymonitor"
phpfina[datadir] = '/var/opt/emoncms/phpfina/'
phptimeseries[datadir] = '/var/opt/emoncms/phptimeseries/'
```

```
sudo mkdir /var/opt/emoncms
sudo mkdir /var/opt/emoncms/phpfina
sudo chown www-data:root /var/opt/emoncms/phpfina
sudo mkdir /var/opt/emoncms/phptimeseries
sudo chown www-data:root /var/opt/emoncms/phptimeseries
sudo mkdir /opt/emoncms
sudo chown ludivine /opt/emoncms
```
## redis
le serveur
```
sudo apt install redis-server
```
redis pour PHP
```
sudo apt-get install -y php-gd php-curl php-pear php-dev php-common php-mbstring
sudo pecl channel-update pecl.php.net
sudo pecl install redis
```
on peut répondre non aux questions

```
sudo nano /etc/php/7.2/mods-available/redis.ini
extension=redis.so

sudo phpenmod redis
sudo systemctl restart apache2
```
pyredis 
```
pip3 install redis
```

## phpRedisAdmin
```
cd /opt/openenergymonitor/
sudo git clone https://github.com/ErikDubbelboer/phpRedisAdmin.git
cd phpRedisAdmin
sudo git clone https://github.com/nrk/predis.git vendor
```

```
sudo systemctl restart apache2
```
## services

```
cd ~
wget https://raw.githubusercontent.com/openenergymonitor/EmonScripts/master/common/install_emoncms_service.sh
chmod +x install_emoncms_service.sh
./install_emoncms_service.sh /opt/openenergymonitor/emoncms/scripts/services/feedwriter/feedwriter.service feedwriter
./install_emoncms_service.sh /opt/openenergymonitor/emoncms/scripts/services/service-runner/service-runner.service service-runner
sudo mkdir /lib/systemd/system/service-runner.service.d
sudo nano /lib/systemd/system/service-runner.service.d/service-runner.conf
[Service]
User=ludivine
sudo mkdir /lib/systemd/system/feedwriter.service.d
sudo nano /lib/systemd/system/feedwriter.service.d/feedwriter.conf
[Service]
Environment='USER=ludivine'
```
```
sudo visudo
```
une tabulation au lieu d'un espace entre (ALL) et le NOPASSWD
```
ludivine ALL=(ALL)      NOPASSWD:ALL
```

## Modules

```
cd /opt/openenergymonitor/emoncms/Modules
git clone -b stable http://github.com/emoncms/graph.git
mkdir modules
cd modules
git clone -b stable http://github.com/emoncms/sync.git
ln -s /opt/emoncms/modules/sync/sync-module /opt/openenergymonitor/emoncms/Modules/sync
```
**aller dans le module d'administration et faire une mise à jour de base**

il faut modifier le chemin dans /opt/emonncms/modules/sync/sync_run.php, ligne 11:
```
chdir("/opt/openenergymonitor/emoncms");
```
Si on a oublié de modifier en conséquence le chemin dans sync_run.php et qu'on a lancé des synchros, il faut lancer à la main le process pour traiter les clé redis
```
cd /opt/emoncms/modules/sync
sudo php sync_run.php
```

# DETAILS

pas sur que ce soit utile :
```
sudo nano /etc/apache2/apache2.conf
```
Pour `<Directory />` et `<Directory /var/www/>` on change `AllowOverride None` par `AllowOverride All`

```
sudo nano /etc/apache2/sites-available/000-default.conf
```

on rajoute dans le virtual host :
```
Alias /emoncms  /opt/openenergymonitor/emoncms
<Directory /opt/openenergymonitor/emoncms/>
  Options Indexes FollowSymLinks
  AllowOverride All
  Require all granted
</Directory>
```

```
sudo nano /etc/apache2/sites-available/000-default.conf
```

```
Alias /phpRedisAdmin  /opt/openenergymonitor/phpRedisAdmin
<Directory /opt/openenergymonitor/phpRedisAdmin/>
  Options Indexes FollowSymLinks
  AllowOverride All
  Require all granted
</Directory>
```
puisque emoncms n'est pas dans /var/www, il faut modifier les fichiers de service pour y inclure les bons chemins
```
nano /opt/openenergymonitor/emoncms/scripts/services/feedwriter/feedwriter.service
nano /opt/openenergymonitor/emoncms/scripts/services/service-runner/service-runner.service
```
