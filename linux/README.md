https://www.linuxtricks.fr/wiki/wiki.php

# maj de ubuntu 18LTS à 20

https://lecrabeinfo.net/mettre-a-jour-ubuntu-18-04-19-10-vers-20-04-lts.html#via-le-terminal

# github desktop sous Ubuntu

https://github.com/shiftkey/desktop

# créer un raccourci lanceur
créer un fichier .desktop :
```
cd /usr/share/applications
sudo touch atom.desktop
sudo nano atome.desktop
```
avec le contenu suivant :

```
[Desktop Entry]
Type=Application
Name=atom
GenericName=atom
Comment=code edition
Icon=/home/alexandrecuer/Documents/atom-1.58.0-amd64/atom.png
Exec=/home/alexandrecuer/Documents/atom-1.58.0-amd64/./atom
Terminal=false  #ouvrir ou non un terminal lors de l'exécution du programme (fa>
StartupNotify=false  #notification de démarrage ou non (false ou true)
Categories=Application
```
