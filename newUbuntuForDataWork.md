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
sudo nano /etc/apache2/apache2.conf
```
Pour `<Directory />` et `<Directory /var/www/>` on change `AllowOverride None` par `AllowOverride All`

```
cd /opt
sudo mkdir openenergymonitor
sudo chown ludivine openenergymonitor/
cd openenergymonitor/
git clone http://github.com/emoncms/emoncms.git
cd /etc/apache2/sites-available
sudo nano 000-default.conf.conf
```

on rajoute dans le virtual host :
```
Alias /emoncms  /opt/openenergymonitor/emoncms
<Directory /opt/openenergymonitor/emoncms/>
  Options Indexes FollowSymLinks
  AllowOverride None
  Require all granted
</Directory>
```

```
sudo mkdir /var/log/emoncms
sudo touch /var/log/emoncms/emoncms.log
sudo chmod 666 /var/log/emoncms/emoncms.log
```
