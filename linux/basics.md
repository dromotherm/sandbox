# OS version
```
cat /etc/os-release
```

# Voir le partionnement du disque dur
ou la mémoire flash utilisée sur la SD lorsqu'on est sur rapsberry
```
df -h
```

# taille d'un répertoire

```
du -c path_folder
```

# Vérifier le modèle de raspberry

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
