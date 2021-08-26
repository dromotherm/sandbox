# tracking init_resize modifications

raspbian init resize file

https://github.com/RPi-Distro/raspi-config/blob/master/usr/lib/raspi-config/init_resize.sh

our file needed to be reconfigured to integrate their changes

tracability of our only changes is here :

https://github.com/openenergymonitor/EmonScripts/commit/8f5baa011b3a52e8f992a0f075756b363c488f84

# how to manage sectors

1 kibioctet (kio) 	= 2^10 octets 	= 1 024 o 	= 1 024 octets

1 mébioctet (Mio) 	= 2^20 octets 	= 1 024 kio 	= 1 048 576 octets

1 gibioctet (Gio) 	= 2^30 octets 	= 1 024 Mio 	= 1 073 741 824 octets

1 tébioctet (Tio) 	= 2^40 octets 	= 1 024 Gio 	= 1 099 511 627 776 octets

1 pébioctet (Pio) 	= 2^50 octets 	= 1 024 Tio 	= 1 125 899 906 842 624 octets

1 exbioctet (Eio) 	= 2^60 octets 	= 1 024 Pio 	= 1 152 921 504 606 846 976 octets

1 zébioctet (Zio) 	= 2^70 octets 	= 1 024 Eio 	= 1 180 591 620 717 411 303 424 octets

1 yobioctet (Yio) 	= 2^80 octets 	= 1 024 Zio 	= 1 208 925 819 614 629 174 706 176 octets 

https://fr.wikipedia.org/wiki/Octet

Avec des secteurs de 512 octets :

10 Gio = 10 * 1073741824 / 512 = 20971520 secteurs

20 Gio = 41943040 secteurs

# parted

quant on a oublié de modifier le init_resize.sh pour que les datas emoncms occupent la totalité de la carte 32 Go, l'espace est alloué au système sur mmcblk0p2 

```
sudo parted -s -a opt /dev/mmcblk0 "print free"
Model: SD SC32G (sd/mmc)
Disk /dev/mmcblk0: 31.9GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags: 

Number  Start   End     Size    Type     File system  Flags
        16.4kB  4194kB  4178kB           Free Space
 1      4194kB  273MB   268MB   primary  fat32        lba
 2      273MB   21.2GB  20.9GB  primary  ext4
 3      21.2GB  31.9GB  10.7GB  primary  ext2
        31.9GB  31.9GB  524kB            Free Space
```

```
df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        20G  3.1G   16G  17% /
devtmpfs        430M     0  430M   0% /dev
tmpfs           462M     0  462M   0% /dev/shm
tmpfs           462M   12M  450M   3% /run
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
tmpfs           462M     0  462M   0% /sys/fs/cgroup
tmpfs            30M     0   30M   0% /tmp
tmpfs           1.0M  4.0K 1020K   1% /var/lib/php/sessions
tmpfs           1.0M     0  1.0M   0% /var/tmp
/dev/mmcblk0p3  9.9G  3.8M  9.4G   1% /var/opt/emoncms
/dev/mmcblk0p1  253M   49M  205M  20% /boot
log2ram          50M  7.0M   44M  14% /var/log
tmpfs            93M     0   93M   0% /run/user/1000
``̀`
