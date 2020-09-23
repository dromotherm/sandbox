On peut installer mysql avec le scripts issu des EmonScripts....
On part du principe qu'on a cloner le dépot des scripts dans /opt/openenergymonitor, répertoire que l'on a donné à l'user en cours, içi alexandrecuer

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
Pour `<Directory />` at `<Directory /var/www/>` on change `AllowOverride None` par `AllowOverride All`

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

reste à configurer les services essentiels feedwriter et service-runner 
```
cd /opt/openenergymonitor/EmonScripts/common
./install_emoncms_service.sh /var/www/emoncms/scripts/services/feedwriter/feedwriter.service feedwriter
./install_emoncms_service.sh /var/www/emoncms/scripts/services/service-runner/service-runner.service service-runner
```
on crée des drop-ins systemd puisqu'on va tourner avec un user qui n'est pas le même que sur raspberry
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
reste à relancer les services pour rendre les choses opérationnelles :

```
sudo systemctl daemon-reload
sudo systemctl restart {feedwriter.service,service-runner.service}
sudo systemctl restart apache2
```
