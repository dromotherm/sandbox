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
mosquitto_pub -t 'emon/test/t3' -m 12
```


# comment installer le service emoncms_mqtt
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
il n'y a pas l'user dans le service file, peut-être le rajouter et supprimer le dropin
