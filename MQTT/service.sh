#!/bin/bash

servicepath=/var/www/emoncms/scripts/services/emoncms_mqtt/emoncms_mqtt.service
echo "installing emoncms_mqtt to $servicepath"
sudo ln -s $servicepath /lib/systemd/system
sudo systemctl enable emoncms_mqtt.service
sudo systemctl start emoncms_mqtt.service

if [ "$user" != "pi" ]; then
  echo "installing emoncms_mqtt drop-in User=$USER"
  if [ ! -d /lib/systemd/system/emoncms_mqtt.service.d ]; then
    sudo mkdir /lib/systemd/system/emoncms_mqtt.service.d
  fi
  echo $'[Service]\nEnvironment="USER=$USER"' > emoncms_mqtt.conf
  sudo mv emoncms_mqtt.conf /lib/systemd/system/emoncms_mqtt.service.d/emoncms_mqtt.conf
fi
sudo systemctl daemon-reload
sudo systemctl restart emoncms_mqtt.service
