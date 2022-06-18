# Autour des kernel headers

pour connaître la version de son noyau

```
uname -r
5.15.32-v7+
```

pour crosscompiler le noyau :

https://www.raspberrypi.com/documentation/computers/linux_kernel.html#cross-compiling-the-kernel

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
cd /lib/modules/$(uname -r)
sudo ln -s ./build /usr/src/linux-headers-$(uname -r)
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
