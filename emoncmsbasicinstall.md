# Installation d'un serveur emoncms avec les workers feedwriter/service-runner et les modules sync/graph/postprocess 

On peut installer mysql avec le scripts issu des EmonScripts....
On part du principe qu'on a cloné le dépot des scripts dans `/opt/openenergymonitor`, répertoire que l'on a donné au sudoer, içi alexandrecuer

Pour vérifier qu'on a bien affaire à un sudoer : `id alexandrecuer` ou `grep "alexandrecuer" /etc/group`

*Nota pour info :*
pour créer un utilisateur avec des privilèges particuliuers sur le port série : `sudo useradd -M -r -G dialout,tty -c "emonHub user" emonhub`. Si l'utilisateur est existant : `sudo usermod -a -G dialout,tty alexandrecuer`

on installe les extensions mysql pour php :

```
sudo apt-get install -y php-mysql
```
on active modrewrite
```
sudo a2enmod rewrite
```
on édite apache2.conf
```
sudo nano /etc/apache2/apache2.conf
```
Pour `<Directory />` et `<Directory /var/www/>` on change `AllowOverride None` par `AllowOverride All`

# emoncms

```
cd /var/www
git clone http://github.com/emoncms/emoncms.git
sudo mkdir /var/log/emoncms
sudo chown alexandrecuer /var/log/emoncms
sudo touch /var/log/emoncms/emoncms.log
sudo chmod 666 /var/log/emoncms/emoncms.log

```
on crée un fichier settings.ini et on le paramètre selon notre convenance
```
cd /var/www/emoncms
touch settings.ini
```
on colle à l'intérieur le contenu de :
https://github.com/openenergymonitor/EmonScripts/blob/master/defaults/emoncms/emonpi.settings.ini

On change un certain nombre de chemins :
```
emoncms_dir = "/opt/emoncms"
openenergymonitor_dir = "/opt/openenergymonitor"
phpfina[datadir] = '/var/opt/emoncms/phpfina/'
phptimeseries[datadir] = '/var/opt/emoncms/phptimeseries/'
```
on peut ne pas activer mqtt si on fait une install de serveur REST only

on crée ensuite les répertoires :
```
sudo mkdir /var/opt/emoncms
sudo mkdir /var/opt/emoncms/phpfina
sudo chown www-data:root /var/opt/emoncms/phpfina
sudo mkdir /var/opt/emoncms/phptimeseries
sudo chown www-data:root /var/opt/emoncms/phptimeseries
sudo mkdir /opt/emoncms
sudo chown alexandrecuer /opt/emoncms
```
on passe à la configuration du virtualhost :
```
cd /var/www/html
sudo ln -s /var/www/emoncms
sudo nano /etc/apache2/sites-available/emoncms.conf
<VirtualHost *:80>
    ServerName localhost/emoncms
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/emoncms

    # Virtual Host specific error log
    ErrorLog /var/log/emoncms/apache2-error.log
    # Access log disabled
    # CustomLog /var/log/emoncms/apache2-access.log combined    
</VirtualHost>
sudo a2ensite emoncms
```
on peut éventuellement rajouter la partie suivante dans la configuration du virtualhost mais celà n'est pas nécessaire :
```
    <Directory /var/www/emoncms>
        Options FollowSymLinks
        AllowOverride All
        DirectoryIndex index.php
        Order allow,deny
        Allow from all
    </Directory>
```

## configuration des services feedwriter et service-runner

### 1) on crée les symlinks

on se sert du script crée par Trystan

```
cd /opt/openenergymonitor/EmonScripts/common
./install_emoncms_service.sh /var/www/emoncms/scripts/services/feedwriter/feedwriter.service feedwriter
./install_emoncms_service.sh /var/www/emoncms/scripts/services/service-runner/service-runner.service service-runner
```
Mais il serait aussi facile de les créer à la main `sudo ln -s $servicepath /lib/systemd/system`

### 2) on crée des dropins systemd pour préciser l'utilisateur qui va faire tourner les services
```
sudo mkdir /lib/systemd/system/service-runner.service.d
sudo nano /lib/systemd/system/service-runner.service.d/service-runner.conf
[Service]
User=alexandrecuer
```
et 
```
sudo mkdir /lib/systemd/system/feedwriter.service.d
sudo nano /lib/systemd/system/feedwriter.service.d/feedwriter.conf
[Service]
Environment='USER=alexandrecuer'
```
### 3) on donne le pouvoir de sudoer sans password à notre utilisateur
```
sudo visudo
```
on rajoute la ligne suivante à la fin du fichier et on enregistre
```
alexandrecuer ALL=(ALL) NOPASWD: ALL
```
### 4) reste à relancer les services pour rendre les choses opérationnelles

```
sudo systemctl daemon-reload
sudo systemctl restart {feedwriter.service,service-runner.service}
sudo systemctl restart apache2
```
Pour voir le log du service-runner :
```
sudo journalctl -f -u service-runner
```

# Modules

## cas d'un module ne résidant pas dans /var/www/emoncms/Modules
Avant d'installer le premier module de ce type :
```
cd /opt/emoncms
mkdir modules
cd modules
```
On clone sync par exemple
```
cd /opt/emoncms/modules
git clone -b stable http://github.com/emoncms/sync.git
ln -s /opt/emoncms/modules/sync/sync-module /var/www/emoncms/Modules/sync
```
Si le module contient un install.sh, on le lance en lui donnant le nom du répertoire openenergymonitor_dir : ce n'est pas le cas pour sync

Par contre, il faut mettre à jour la base de données : pour celà, aller dans le modèle d'administration et faire une mise à jour de base 

## cas d'un module résidant dans /var/www/emoncms/Modules

```
cd /var/www/emoncms/Modules
git clone -b stable http://github.com/emoncms/graph.git
```
