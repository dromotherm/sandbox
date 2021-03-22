sandbox - diverses méthodes en tt genre :-)


# md5 bios 32 Go Sandisk - 17/03/2021
```
45b5ff83cbd5a45573fad44c2ef3a536  bios.img.zip
d8012c497545175a9cc0a8e2a8cd944c  bios.img
```


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
Un fdisk nous permet de vérifier que la carte dont on veut créer une image est constituée de secteurs de 512 octets et qu'elle en comporte 30228479+1 (car on commence à compter à 0). On est bien sur une carte de 16 Go car 30228480/2 = 15 114 240 et 15114240 * 1024 = 15476981760 bytes ce qui est bien le résultat de la commande dd.... 

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

ou avec gparted
```
sudo udisksctl loop-setup -f test.img
Mapped file test.img as /dev/loop19.
```
puis :
```
sudo gparted /dev/loop19 &
```
on peut alors créer un zip pour compresser et gagner de l'espace...

```
zip test.img.zip test.img
  adding: test.img (deflated 92%)
```
on vérifie la taille du zip (1.2 Go)

```
ls -al test.img.zip
-rw-r--r-- 1 alexandrecuer alexandrecuer 1232455476 août  29 13:36 test.img.zip
```
On vérifie les md5 (utile pour s'assurer que le fichier n'est pas corrompu - cas d'un stockage sur le cloud et d'un téléchargement ultérieur)

```
md5sum test.img.zip
8917daf0e78e372448eaebe84c3bfc40  test.img.zip

md5sum test.img
1a5353f9a4cc8163515bc5941589e4ba  test.img
```
Sous windows :
```
certutil -hashfile Themis1.0.img.zip MD5
```
