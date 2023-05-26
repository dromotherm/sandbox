#!/bin/bash
# install emoncms stack on jetson nano with php7.4

sudo git config --system --replace-all safe.directory '*'

sudo echo $USER' ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/$USER && sudo chmod 0440 /etc/sudoers.d/$USER

git clone https://github.com/openenergymonitor/EmonScripts
cp EmonScripts/install/emonsd.config.ini EmonScripts/install/config.ini

wget https://raw.githubusercontent.com/dromotherm/sandbox/master/makefile

read -rsn1 -p"Press any key to update os";echo
make osupdate
# install dependancies
read -rsn1 -p"Press any key to install apache";echo
make apache
read -rsn1 -p"Press any key to install php";echo
make mysql
read -rsn1 -p"Press any key to install php 7.4";echo
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt install php7.4
sudo apt-get install -y libapache2-mod-php
sudo apt-get install -y php-gd php-pear php-common
sudo apt install php7.4-curl php7.4-mbstring php7.4-xml php7.4-igbinary php7.4-dev php7.4-mysql
read -rsn1 -p"Press any key to install redis";echo
make redis
read -rsn1 -p"Press any key to install mosquitto";echo
make mosquitto
# install engine and services
read -rsn1 -p"Press any key to install emoncms";echo
make emoncms_www
make sudoers
make apacheconf
read -rsn1 -p"Press any key to install feedwriter";echo
make feedwriter
read -rsn1 -p"Press any key to install service-runner";echo
make service-runner
read -rsn1 -p"Press any key to install mqtt service";echo
make emoncms_mqtt
# install modules
read -rsn1 -p"Press any key to install modules";echo
make module name=graph
make module name=dashboard
make symodule name=sync
make symodule name=postprocess
make symodule name=backup