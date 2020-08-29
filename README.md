sandbox to track mods

# create image from SD cards

L'idée est de créer une image qui passe sur toutes les marques de cartes SD a compter d'une certaine taille (16 Go)

Les principales marques que l'on trouve sur Raspberry :

- Sandisk
 
- Kingston

- Goodram

La plus petite en taille est la Kingston

Il faut donc créer l'image à partir d'une Kingston  contenant tout l'écosystème

# panorama des outils existants

https://learn.sparkfun.com/tutorials/sd-cards-and-writing-images/all

## si l'on veut un outil tout prêt sous windows....

http://sourceforge.net/projects/win32diskimager/

Utiliser l'option `Read` soit : 

read data from 'Device' to 'Image File'

Il faut bien sûr avoir auparavant donné un nom d'image

## sous linux Ubuntu

**probablement le plus simple et le plus intelligent car tous les outils sont disponibles et car on voit vraiment ce que l'on fait**

on cherche le point de montage de la carte (içi une Kingston), par exemple /dev/mmcblk0
```
sudo fdisk -l /dev/mmcblk0
Disque /dev/mmcblk0 : 14,4 GiB, 15476981760 octets, 30228480 secteurs
Unités : secteur de 1 × 512 = 512 octets
Taille de secteur (logique / physique) : 512 octets / 512 octets
taille d'E/S (minimale / optimale) : 512 octets / 512 octets
Type d'étiquette de disque : dos
Identifiant de disque : 0xd53a1f88

Périphérique   Amorçage   Début      Fin Secteurs Taille Id Type
/dev/mmcblk0p1             8192   532479   524288   256M  c W95 FAT32 (LBA)
/dev/mmcblk0p2           532480  9256959  8724480   4,2G 83 Linux
/dev/mmcblk0p3          9256960 30228479 20971520    10G 83 Linux
```
Un fdisk nous permet de vérifier que la carte dont on veut créer une image est constituée de secteurs de 512 octets et qu'elle en comporte 30228479+1 (car on commence à compter à 0)

On utilise dd pour créer l'image :
```
sudo dd if=/dev/mmcblk0 bs=512 count=30228480 of=test.img
30228480+0 enregistrements lus
30228480+0 enregistrements écrits
15476981760 bytes (15 GB, 14 GiB) copied, 836,52 s, 18,5 MB/s
```
On vérifie avec un fdisk :
```
fdisk -l test.img
Disque test.img : 14,4 GiB, 15476981760 octets, 30228480 secteurs
Unités : secteur de 1 × 512 = 512 octets
Taille de secteur (logique / physique) : 512 octets / 512 octets
taille d'E/S (minimale / optimale) : 512 octets / 512 octets
Type d'étiquette de disque : dos
Identifiant de disque : 0xd53a1f88

Périphérique Amorçage   Début      Fin Secteurs Taille Id Type
test.img1                8192   532479   524288   256M  c W95 FAT32 (LBA)
test.img2              532480  9256959  8724480   4,2G 83 Linux
test.img3             9256960 30228479 20971520    10G 83 Linux
```


