On peut installer mysql avec le scripts issu des EmonScripts....

```
cd /var/www
git clone http://github.com/emoncms/emoncms.git
sudo mkdir /var/log/emoncms
sudo chown alexandrecuer /var/log/emoncms
sudo touch /var/log/emoncms/emoncms.log
sudo chmod 666 /var/log/emoncms/emoncms.log

```

```
cd /var/www/emoncms
touch settings.ini
```
on colle à l'intérieur le contenu de :
https://github.com/openenergymonitor/EmonScripts/blob/master/defaults/emoncms/emonpi.settings.ini

On change un certain nombre de chemins :
```
emoncms_dir = "/var/www/emoncms"
openenergymonitor_dir = "/opt/openenergymonitor"
phpfina[datadir] = '/var/opt/emoncms/phpfina/'
phptimeseries[datadir] = '/var/opt/emoncms/phptimeseries/'
```
on peut ne pas activer mqtt si on fait une install de serveur REST only
