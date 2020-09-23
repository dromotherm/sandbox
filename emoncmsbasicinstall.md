On peut installer mysql avec le scripts issu des EmonScripts....
On part du principe qu'on a cloner le dépot des scripts dans /opt/openenergymonitor, répertoire que l'on a donné à l'user en cours, içi alexandrecuer

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
emoncms_dir = "/opt/emoncms"
openenergymonitor_dir = "/opt/openenergymonitor"
phpfina[datadir] = '/var/opt/emoncms/phpfina/'
phptimeseries[datadir] = '/var/opt/emoncms/phptimeseries/'
```
on peut ne pas activer mqtt si on fait une install de serveur REST only

```
sudo mkdir /var/opt/emoncms
sudo mkdir /var/opt/emoncms/phpfina
sudo chown www-data:root /var/opt/emoncms/phpfina
sudo mkdir /var/opt/emoncms/phptimeseries
sudo chown www-data:root /var/opt/emoncms/phptimeseries
```
