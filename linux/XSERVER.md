# réinstaller le serveur X

lorsque seule la ligne de commande est accessible après une mise à jour et que le réseau fonctionne, on peut réinstaller le serveur X

https://doc.ubuntu-fr.org/xorg

```
sudo apt install xserver-xorg-core
sudo apt install xserver-xorg-input-all xserver-xorg-input-libinput xserver-xorg-input-mouse xserver-xorg-input-kbd
```
cf https://www.antixforum.com/forums/topic/how-to-re-install-x-from-terminal/

`sudo apt autoremove` peut être utile pour supprimer tous les paquets ayant planté....

```
sudo apt install lightdm
sudo apt install kde-plasma-desktop
sudo dpkg-reconfigure gdm3
```
