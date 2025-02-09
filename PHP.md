list installed modules :
```
php -m
```
list available modules/extensions :
```
php -i | grep extension_dir
```

to check php.ini settings in command line :

```
php -i
```

# installing PHP 7.4

using https://github.com/oerdnj PPA (Personal Package Archive)

cf https://launchpad.net/~ondrej/+archive/ubuntu/php/ and https://deb.sury.org/#bug-reporting

```
sudo apt-get update
sudo apt -y install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo add-apt-repository ppa:ondrej/apache2
sudo apt-get update
```
installing php7.4
```
sudo apt -y install php7.4
sudo apt-get install -y php7.4-{mysql,gd,curl,dev,common,mbstring}
```
enabling php7.4 and disabling php7.2
```
sudo a2dismod php7.2
sudo a2enmod php7.4
sudo systemctl restart apache2
```

NOTA : all what is below is managed in the Dockerfile now, we keep for history

# phpredis

pear/pecl is not really maintained and will not be available in further php versions : cf https://forum.directadmin.com/threads/php-7-4-pecl.59649/ and https://externals.io/message/103977

so installation of phpredis has to be made with phpize : cf https://github.com/phpredis/phpredis/blob/develop/INSTALL.markdown

```
git clone https://github.com/phpredis/phpredis
cd phpredis
```
running phpize to generate configure and makefile
```
phpize
Configuring for:
PHP Api Version:         20190902
Zend Module Api No:      20190902
Zend Extension Api No:   320190902
```
```
./configure
make
sudo makeinstall
printf "extension=redis.so" | sudo tee /etc/php/7.4/mods-available/redis.ini 1>&2
sudo phpenmod redis
sudo systemctl restart apache2
```
# Mosquitto-PHP

```
git clone https://github.com/mgdm/Mosquitto-PHP
cd Mosquitto-PHP/
phpize
./configure
make
sudo make install
printf "extension=mosquitto.so" | sudo tee /etc/php/7.4/mods-available/mosquitto.ini 1>&2
sudo phpenmod mosquitto
sudo systemctl restart apache2
```

[Zend Modules]
Zend OPcache
```
