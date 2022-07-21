pour voir les différences : `git diff`

# emoncms bios version

on peut choisir une branche bios_master, bios_stable
```
git config --list
git remote set-url origin https://github.com/alexandrecuer/emoncms.git
git pull
git branch -a
git checkout bios_master
```
on installe OBMmonitor
```
cd /var/www/emoncms/Modules
git clone https://github.com/alexjunk/OBMmonitor
```

# ceremaida : migration vers menu_v3
```
cd /var/www/emoncms
```
Si l'on veut fonctionner avec la branche master d'emoncms
```
git remote set-url origin https://github.com/emoncms/emoncms.git
git pull
```
Si l'on veut fonctionner avec la branche bios_master d'emoncms
```
git remote set-url origin https://github.com/alexandrecuer/emoncms.git
git pull
git checkout bios_master
```
On update les modules:
```
cd Modules
cd graph
git pull
cd OBMmonitor
git pull
```
La liste des services pris en compte par OBMmonitor est précisée dans la variable $services du fichier shared.php

Cette variable est une liste contenant autant de lignes que de services. Exemple :

"enless"=>"over the air primitive version" 

Mais OBMmonitor n'affichera pas les log correctement puisque cette version initiale utilise comme log /var/log/bios/ota.log

```
cd /opt/emoncms/modules
cd postprocess
git pull
cd ..
cd sync
git pull
```
on ne fait rien pour backup dont l'installation n'a pas été correctement fait à l'origine

# ceremaida : migration vers la nouvelle version de bios

l'idée est de changer 2 services : enless par ota2 et modbusTCP par sa nouvelle version

on va procéder service par service, on ne prend pas le risque d'arrêter les 2 en même temps

on crée un nouveau répertoire BIOS2 par clonage
```
cd /opt/openenergymonitor
git clone http://github.com/alexjunk/BIOS ./BIOS2
```
## modbusTCP

```
cd BIOS
make modbusTCPuninstall
cd ..
cd BIOS2
cd hardware
./modbusTCP.py
make install name=modbusTCP
```

## ota

```
cd BIOS
make otauninstall
cd ..
cd BIOS2
cd hardware
./ota2.py
make install name=ota2
```

