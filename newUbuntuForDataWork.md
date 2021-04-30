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

```
