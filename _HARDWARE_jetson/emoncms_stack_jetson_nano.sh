#!/bin/bash
# install emoncms stack on jetson nano with php7.4

# give access to serial port
sudo usermod -a -G dialout $USER

# do not upgrade kernel
dpkg -S /boot/Image
sudo apt-mark hold nvidia-l4t-kernel nvidia-l4t-kernel-dtbs nvidia-l4t-kernel-headers nvidia-l4t-bootloader

sudo apt-get install -y git build-essential python3-pip python3-dev
python3 -m pip install pip --upgrade
python3 -m pip install pyserial

# remove some errors in emoncms admin module
sudo git config --system --replace-all safe.directory '*'

# for sync module
sudo echo $USER' ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/$USER && sudo chmod 0440 /etc/sudoers.d/$USER

# for backup module quiet install
git clone https://github.com/openenergymonitor/EmonScripts
cp EmonScripts/install/emonsd.config.ini EmonScripts/install/config.ini

wget https://raw.githubusercontent.com/dromotherm/sandbox/master/makefile

read -rsn1 -p"Press any key to update os";echo
make osupdate
# install dependancies
read -rsn1 -p"Press any key to install apache";echo
make apache
read -rsn1 -p"Press any key to install mariadb";echo
make mysql
read -rsn1 -p"Press any key to install php 7.4";echo
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt install php7.4
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
