# MQTT broker exploration

https://github.com/thomasnordquist/MQTT-Explorer

http://mqtt-explorer.com/

```
sudo dpkg -i MQTT-Explorer_0.4.0-beta.6_amd64.deb
```

# emqx

https://javiermugueta.blog/2023/12/19/integrating-iot-lora-sensors-with-home-assistant-via-the-things-network/

https://github.com/emqx/emqx

# open MQTT gateway

https://github.com/1technophile/OpenMQTTGateway

# mosquitto

pour tester le client mosquitto en ligne de commande :
```
sudo apt-get install mosquitto-clients
```
on peut ensuite souscrire au topic emon :
```
mosquitto_sub -v -u 'emonpi' -P 'emonpimqtt2016' -t 'emon/#'
```
pour publier :
```
mosquitto_pub -u "emonpi" -P "emonpimqtt2016" -t 'emon/test/t3' -m 12
```


# comment installer le service emoncms_mqtt

Désormais c'est le makefile de BIOS qui crée le fichier service mais la procédure Openenergymonitor est la suivante :
 
```
chmod +x mosquitto.sh
./mosquitto.sh
chmod +x service.sh
./service.sh
pip3 install paho-mqtt
```
Dans settings.ini d'emoncms, ne pas oublier d'activer mqtt
```
[mqtt]
enabled = true
```
Il n'y a pas l'user dans le service file, peut-être le rajouter et supprimer le dropin que crée service.sh

Édit : le makefile ne rajoute pas l'user et ne crée pas de dropin
