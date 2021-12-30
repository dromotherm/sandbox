# Installation d’un nouveau disque dur

```
pi@raspberrypi:~$ sudo fdisk -l
Device         Boot  Start      End  Sectors  Size Id Type
/dev/mmcblk0p1        8192   137215   129024   63M  c W95 FAT32 (LBA)
/dev/mmcblk0p2      137216 30318591 30181376 14.4G 83 Linux

Disk /dev/sda: 931.5 GiB, 1000170586112 bytes, 1953458176 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
```

Les unités mmcblk0p1 et 2 correspondent à la carte SD sur laquelle est installée le système.

L’unité sda correspond au disque dur de 1 To que l’on vient de connecter

On installe ensuite le package gparted qui offre un outil de partitionnement

On crée une nouvelle table de partitionnement de type msdos (si on a un disque de moins de 2 To)

On peut créer ensuite 3 partitions primaires (swap de 100 Mo, linux ext4 de 700 Go, fat32 de 200 Go)

Celà crée dans /dev 3 partitions : sda1, dsa2 et sda3

pour savoir quel est le type de partitionnement des disques durs :
```
pi@raspberrypi:~$ sudo parted -l
Model: WD My Passport 25A0 (scsi)
Disk /dev/sda: 1000GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags:

Number  Start  End  Size  Type  File system  Flags


Model: SD SD16G (sd/mmc)
Disk /dev/mmcblk0: 15.5GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags:

Number  Start   End     Size    Type     File system  Flags
 1      4194kB  70.3MB  66.1MB  primary  fat16        lba
 2      70.3MB  15.5GB  15.5GB  primary  ext4
```

On monte sda2 dans un répertoire /USB1
```
pi@raspberrypi:~$ sudo mkdir /USB1
pi@raspberrypi:~$ sudo mount /dev/sda2 /USB1
pi@raspberrypi:~$ df
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       14790752 5898540   8236684  42% /
devtmpfs          469540       0    469540   0% /dev
tmpfs             473872       0    473872   0% /dev/shm
tmpfs             473872    6728    467144   2% /run
tmpfs               5120       4      5116   1% /run/lock
tmpfs             473872       0    473872   0% /sys/fs/cgroup
tmpfs              32768      20     32748   1% /tmp
/dev/mmcblk0p1     64456   20984     43472  33% /boot
tmpfs              94776       4     94772   1% /run/user/1000
/dev/sda2      755817384   70440 717330560   1% /USB1
```
Pour rendre le montage pérenne :

```
pi@raspberrypi:~$ sudo nano /etc/fstab
```

```
  GNU nano 2.2.6              File: /etc/fstab

proc            /proc           proc    defaults          0       0
/dev/mmcblk0p1  /boot           vfat    defaults          0       2
/dev/mmcblk0p2  /               ext4    defaults,noatime  0       1
# a swapfile is not a swap partition, no line here
#   use  dphys-swapfile swap[on|off]  for that
tmpfs /tmp tmpfs defaults,size=32M 0 0
/dev/sda2 /USB1 ext4 defaults 0 3












                                [ Read 7 lines ]
^G Get Help  ^O WriteOut  ^R Read File ^Y Prev Page ^K Cut Text  ^C Cur Pos
^X Exit      ^J Justify   ^W Where Is  ^V Next Page ^U UnCut Text^T To Spell
```
On peut déplacer des fichiers vers ce nouveau disque depuis un client samba, en ayant pris soin de nommer l’user samba propriétaire du répertoire /USB1....
On peut ensuite rendre ce répertoire accessible via apache2
```
pi@raspberrypi:~$ chown -R alexandre.cuer /USB1
pi@raspberrypi:~$ cd /etc/apache2
pi@raspberrypi:/etc/apache2$ cd conf-available
pi@raspberrypi:/etc/apache2/conf-available$ sudo nano files.conf
```

```
  GNU nano 2.2.6              File: files.conf

Alias /USB1 /USB1

<Directory /USB1>
        Options Indexes
        Require all granted
</Directory>













                                [ Read 6 lines ]
^G Get Help  ^O WriteOut  ^R Read File ^Y Prev Page ^K Cut Text  ^C Cur Pos
^X Exit      ^J Justify   ^W Where Is  ^V Next Page ^U UnCut Text^T To Spell
```

On relance le service apache
```
pi@raspberrypi:/etc/apache2/conf-available$ sudo service apache2 restart
```
