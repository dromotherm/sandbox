# services et modules UX

Services de niveau I | emplacement sur PI
-- | --
emoncms_mqtt | /var/www/emoncms/scripts/services/emoncms_mqtt/emoncms_mqtt.php
feedwriter | /var/www/emoncms/scripts/feedwriter.php
service-runner | /var/www/emoncms/scripts/services/service-runner/service-runner.py

Services python de niveau II | code source sur github | emplacement sur PI
--|--|--
Emonhub, pour récupérer les données des matériels emonTx et emonPi | http://github.com/openenergymonitor/emonhub | /opt/openenergymonitor/emonhub
ota2, service over the air pour récupérer les données radio 169 Mhz Enless | https://github.com/alexjunk/BIOS/blob/master/hardware/ota2.py | /opt/openenergymonitor/BIOS/hardware
modbusTCP, pour interroger une ligne modbusTCP (promux, pyranomètres KippNzonen) | https://github.com/alexjunk/BIOS/blob/master/hardware/modbusTCP.py | /opt/openenergymonitor/BIOS/hardware
bios, pour piloter des circuits de chaufferie + disposer en temps réel de la météo prévisionnelle sur les 7 prochains jours | https://github.com/alexjunk/BIOS | /opt/openenergymonitor/BIOS

Emoncms est dans /var/www/emoncms

Les modules UX : /var/www/emoncms/Modules

module OBMmonitor qui monitore n'importe quel service associé pourvu qu'il soit déclaré : http://github.com/alexjunk/OBMmonitor

module helloWorld : http://github.com/dromotherm/dromotherm

# récupération des données à distance
la solution 1 est de passer par le module de synchro :
![](sync.svg)
la solution 2 est de faire un backup avec le module de backup et de le décompacter

pour exploiter avec python et numpy :

```
python3 -m pip install PyFina
```

cf https://pypi.org/project/PyFina/
