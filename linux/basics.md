# OS version
```
cat /etc/os-release
```
ou 
```
cat /proc/version
Linux version 6.6.20+rpt-rpi-v7 (debian-kernel@lists.debian.org) (gcc-12 (Raspbian 12.2.0-14+rpi1) 12.2.0, GNU ld (GNU Binutils for Raspbian) 2.40) #1 SMP Raspbian 1:6.6.20-1+rpt1 (2024-03-07)
```

# Voir le partionnement du disque dur
ou la mémoire flash utilisée sur la SD lorsqu'on est sur rapsberry
```
df -h
```
# mémoire occupée
```
free -h
               total        used        free      shared  buff/cache   available
Mem:           920Mi       320Mi       120Mi       1.0Mi       540Mi       600Mi
Swap:           99Mi       1.2Mi        98Mi
```
# taille d'un répertoire

```
du -c path_folder
```

# Vérifier le modèle de raspberry ou l'architecture

`cat /proc/device-tree/model` ou `pinout`

# uname 
```
uname
Linux
```
```
uname -a
Linux emonpi 5.4.51-v7+ #1333 SMP Mon Aug 10 16:45:19 BST 2020 armv7l GNU/Linux
```
with a 32 bits OS and a raspberry PI4 :
```
uname -m
armv7l
```
with a 64 bits OS and a raspberry PI4 :
```
uname -a
Linux raspberrypi 5.10.63-v8+ #1459 SMP PREEMPT Wed Oct 6 16:42:49 BST 2021 aarch64 GNU/Linux

uname -m
aarch64
```

# bash

Pour trouver le bash :

```
which bash
bin/bash
```
# lscpu
```
lscpu
Architecture:        armv7l
Byte Order:          Little Endian
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  1
Core(s) per socket:  4
Socket(s):           1
Vendor ID:           ARM
Model:               4
Model name:          Cortex-A53
Stepping:            r0p4
CPU max MHz:         1200.0000
CPU min MHz:         600.0000
BogoMIPS:            38.40
Flags:               half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32
```
ou
```
cat /proc/cpuinfo
```
