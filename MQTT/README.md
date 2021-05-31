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
