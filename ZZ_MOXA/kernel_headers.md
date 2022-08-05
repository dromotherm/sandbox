Attention, work in progress - cross-compilation du noyau pas encore maîtrisée. Le bus USB ne fonctionne pas correctement une fois le nouveau noyau déployé, et donc les clés modbus non plus :-)

pour connaître la version de son noyau

```
uname -r
5.15.32-v7+
```

Bootlin est une entreprise qui forme à la compilation du noyau : https://bootlin.com/blog/enabling-new-hardware-on-raspberry-pi-with-device-tree-overlays/

https://opensource.com/article/21/7/custom-raspberry-pi-image

https://github.com/RPi-Distro/pi-gen

# Autour des kernel headers

https://wiki.gentoo.org/wiki/Linux-headers

https://kernelnewbies.org/KernelHeaders

https://web.archive.org/web/20171219160722/http://linuxmafia.com/faq/Kernel/usr-src-linux-symlink.html

# Construction à partir des sources

fiche pratique pour cross-compiler le noyau :

https://www.raspberrypi.com/documentation/computers/linux_kernel.html#cross-compiling-the-kernel

https://linux-sunxi.org/Mainline_Kernel_Howto

## obtention des sources 

### par clonage

Pour créer sur notre machine de cross-compilation un répertoire `linux' avec les sources à l'intérieur :
```
git clone --depth=1 https://github.com/raspberrypi/linux
```
On peut choisir la branche correspondant le mieux à la version de son noyau. Par exemple, pour aller sur la version 5.13 du noyau :
```
git clone --depth=1 --branch rpi-5.13.y https://github.com/raspberrypi/linux
```
### par téléchargement

On peut télécharger des sources correspondant à des releases dans https://github.com/raspberrypi/linux/tags

On se repère dans les tags via les dates. Par exemple, pour la raspiOS de 4 Avril 2022 qui utilise le noyau 5.15.32,  on peut prendre le tag https://github.com/raspberrypi/linux/releases/tag/1.20220331 qui date du 31 mars 2022

On télécharge le zip et on dézippe....

Pour vérifier la version du noyau :
```
cd linux-1.20220331/
make kernelversion
5.15.32
```

## génération des headers

Lorsqu'on parcourt les sources à la recherche du mot clé `*headers*` on tombe sur un fichier `Documentation/kbuild/headers_install.rst`
```
cd linux
make headers_install ARCH=arm
```
ou pour le cas d'une distribution 64 bits :
```
make headers_install ARCH=arm64
```
Celà crée les kernel headers dans `usr/include`

On peut alors copier le contenu de ce répertoire vers la carte SD

### si la partition `root` de la carte SD ait été montée dans `mnt/ext4`

```
sudo mkdir mnt/ext4/usr/src/linux-headers-5.13.19-v7+
sudo cp -r usr/include/* mnt/ext4/usr/src/linux-headers-5.13.19-v7+
```
### si on laisse faire la machine hôte lors du montage de la SD
```
sudo mkdir /media/alexandrecuer/rootfs/usr/src/linux-headers-5.15.32-v8+
sudo cp -r usr/include/* /media/alexandrecuer/rootfs/usr/src/linux-headers-5.15.32-v8+
```

Une fois le noyau mis en place et le rapsberry booté, on fait un lien - cf plus loin

# Installation via apt-get
```
sudo apt-get install raspberrypi-kernel-headers
```
Cette méthode installe les kernel headers dans `/usr/src/linux-headers-$(uname -r)` puis crée un lien vers ce répertoire dans `/lib/modules/$(uname -r)`. Ce lien a pour nom `build`.

## exploration de /usr/src

la commande générique :
```
ls -l /usr/src/linux-headers-$(uname -r)
```

## lien vers /lib/modules

S'il n'existe pas, on peut le créer manuellement
```
sudo ln -s /usr/src/linux-headers-$(uname -r) /lib/modules/$(uname -r)/build
```
pour vérifier qu'il existe bien :

```
cd /lib/modules/$(uname -r)
ls -al
```

# Misc

On parcourt le contenu de /usr/src sur une distribution buster 5.10
```
pi@emonpi:/usr/src $ ls
linux-headers-5.10.63+  linux-headers-5.10.63-v7+  linux-headers-5.10.63-v7l+
```
On liste le contenu du répertoire de headers spécifique à la distribution
```
pi@emonpi:/usr/src $ ls -al linux-headers-5.10.63-v7l+
total 1352
drwxr-xr-x  23 root root    4096 Feb 22 10:23 .
drwxr-xr-x   5 root root    4096 Feb 22 10:22 ..
drwxr-xr-x  26 root root    4096 Feb 22 10:23 arch
drwxr-xr-x   3 root root    4096 Feb 22 10:23 block
drwxr-xr-x   2 root root    4096 Feb 22 10:23 certs
-rw-r--r--   1 root root  205349 Dec  4  2021 .config
drwxr-xr-x   4 root root    4096 Feb 22 10:23 crypto
drwxr-xr-x   8 root root    4096 Feb 22 10:23 Documentation
drwxr-xr-x 139 root root    4096 Feb 22 10:23 drivers
drwxr-xr-x  79 root root    4096 Feb 22 10:23 fs
drwxr-xr-x  31 root root    4096 Feb 22 10:23 include
drwxr-xr-x   2 root root    4096 Feb 22 10:23 init
drwxr-xr-x   2 root root    4096 Feb 22 10:23 ipc
-rw-r--r--   1 root root     555 Nov 18  2021 Kconfig
drwxr-xr-x  19 root root    4096 Feb 22 10:23 kernel
drwxr-xr-x  21 root root    4096 Feb 22 10:23 lib
-rw-r--r--   1 root root   65310 Nov 18  2021 Makefile
drwxr-xr-x   3 root root    4096 Feb 22 10:23 mm
-rw-r--r--   1 root root 1001972 Dec  4  2021 Module.symvers
drwxr-xr-x  72 root root    4096 Feb 22 10:23 net
drwxr-xr-x  31 root root    4096 Feb 22 10:23 samples
drwxr-xr-x  17 root root   12288 Feb 22 10:23 scripts
drwxr-xr-x  13 root root    4096 Feb 22 10:23 security
drwxr-xr-x  26 root root    4096 Feb 22 10:23 sound
drwxr-xr-x  32 root root    4096 Feb 22 10:23 tools
drwxr-xr-x   3 root root    4096 Feb 22 10:23 usr
drwxr-xr-x   4 root root    4096 Feb 22 10:23 virt
```
