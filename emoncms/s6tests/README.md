https://github.com/just-containers/s6-overlay

# pourquoi s6

https://skarnet.org/software/s6-rc/why.html

# mosquitto in s6

sur architecture armv7, mosquitto installé via apt-get et lancé via s6 ne fonctionnait pas correctement

on a donc recompilé depuis les sources, tel que le fait home-assistant pour son addon mosquitto, cf https://github.com/home-assistant/addons/tree/master/mosquitto

pour publier sur le broker depuis le container lui-même
```
apt-get install mosquitto-clients
mosquitto_pub -t 'emon/test/t3' -m 12
```

depuis une machine distante
```
mosquitto_pub -h 192.168.1.13 -p 7883 -u "emonpi" -P "emonpimqtt2016" -t 'emon/test/t3' -m 12
```

pour publier depuis une machine distante, il faut auparavant avoir ouvert le port 1883 dans la conf du broker
```
listener 1883
```

# home-assistant addon

L'idée des addon est très intéressante 

Mais la construction d'un nouvel addon se fait mieux en ligne de commande que depuis l'interface web du supervisor

Quant on reconstruit une image docker pour home-assistant en ligne de commande

```
docker build -t local/armv7-addon-lamp .
```

on tague ensuite l'image sans incrémenter le numéro de version

Si on en est à la version 1.0.1
```
docker tag local/armv7-addon-lamp local/armv7-addon-lamp:1.0.1
```
puis on restarte l'addon et la nouvelle image est prise en compte

le versionning sert une fois que le premier développement est fait, pour suivre les évolutions


