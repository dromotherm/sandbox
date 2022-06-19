Pour savoir d'où provient un paquet :
```
apt show redis-server
```
le retour est le suivant :
```
Package: redis-server
Version: 5:6.0.16-1+deb11u2
Priority: optional
Section: database
Source: redis
Maintainer: Chris Lamb <lamby@debian.org>
Installed-Size: 196 kB
Pre-Depends: init-system-helpers (>= 1.54~)
Depends: lsb-base (>= 3.2-14), redis-tools (= 5:6.0.16-1+deb11u2)
Homepage: https://redis.io/
Tag: implemented-in::c, role::program
Download-Size: 98.2 kB
APT-Manual-Installed: yes
APT-Sources: http://deb.debian.org/debian bullseye/main arm64 Packages
Description: Persistent key-value database with network interface
 Redis is a key-value database in a similar vein to memcache but the dataset
 is non-volatile. Redis additionally provides native support for atomically
 manipulating and querying data structures such as lists and sets.
 .
 The dataset is stored entirely in memory and periodically flushed to disk.
```
 
Il y a un certains nombre de paquets maintenus par la fondation raspberry
 
https://archive.raspberrypi.org/debian/
