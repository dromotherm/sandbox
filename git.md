# emoncms bios version
```
git config --list
git remote set-url origin https://github.com/alexandrecuer/emoncms.git
git branch -a
git checkout bios_menuv3
```
on installe seulement graph, sync et OBMmonitor (branche v3menu)

# ceremaida : migration vers menu_v3
```
cd /var/www/emoncms
```
Si l'on veut fonctionner avec la branche master d'emoncms
```
git remote set-url origin https://github.com/emoncms/emoncms.git
git pull
```
Si l'on veut fonctionner avec la branche bios_menuv3 d'emoncms
```
git remote set-url origin https://github.com/emoncms/emoncms.git
git pull
git checkout bios_menuv3
```
On update les modules:
```
cd Modules
cd graph
git pull
cd OBMmonitor
git pull
git checkout v3menu
```
on peut modifier le fichier shared.php en rajoutant "enless"=>"over the air primitive version" dans $services 

Mais OBMmonitor n'affichera pas les log correctement puisque cette version initiale utilise comme log /var/log/bios/ota.log




