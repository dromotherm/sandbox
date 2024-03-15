L'application web Emoncms est dans /var/www/emoncms

# services

Services de niveau I | emplacement
-- | --
emoncms_mqtt | /var/www/emoncms/scripts/services/emoncms_mqtt/emoncms_mqtt.php
feedwriter | /var/www/emoncms/scripts/feedwriter.php
service-runner | /var/www/emoncms/scripts/services/service-runner/service-runner.py

Services python de niveau II | commentaire
--|--
Emonhub | pour récupérer les données des matériels emonTx et emonPi
ota2 | service over the air pour récupérer les données radio 169 Mhz Enless
modbus | pour interroger un bus de terrain (promux, pyranomètres KippNzonen)
bios | pour piloter des circuits de chaufferie + météo prévisionnelle sur les 7 prochains jours

Les sources :
- bios est à la racine des sources de bios
- modbus et ota2 sont dans le répertoire hardware de bios
- emonhub est sur le repo http://github.com/openenergymonitor/emonhub

Documentation ota2, modbusTCP : https://github.com/alexjunk/BIOS2/tree/master/hardware

On y trouve le positionnement des jumpers pour le récepteur enless en mode USB

Pour plus détails sur les produits de la startup OEM développant emoncms, cf https://github.com/openenergymonitor/EmonScripts/blob/master/EmonPiFileSystem.md#emoncms-systemd-services

# récupération des données à distance
la solution 1 est de passer par le module de synchro :
![](sync/sync.svg)
la solution 2 est de faire un backup avec le module de backup et de le décompacter

pour exploiter avec python et numpy :

```
python3 -m pip install PyFina
```

cf https://pypi.org/project/PyFina/
