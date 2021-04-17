# Système de télésurveillance

https://github.com/kerberos-io/kios

dernière image : https://github.com/kerberos-io/kios/releases/tag/v2.8.0

on la grave avec balena etcher, sur une carte de 32 Go

Après le premier reboot et le redimensionnement, on peut se connecter en ssh avec l'utilisateur root
```
[root@kios-f5768f26 ~]# df -h
Filesystem                Size      Used Available Use% Mounted on
/dev/root               363.1M    331.1M      9.3M  97% /
devtmpfs                369.3M         0    369.3M   0% /dev
tmpfs                   373.8M         0    373.8M   0% /dev/shm
tmpfs                   373.8M      2.3M    371.5M   1% /tmp
/dev/mmcblk0p1           29.9M     14.7M     15.2M  49% /boot
/dev/mmcblk0p3           28.1G     53.5M     26.6G   0% /data
/dev/mmcblk0p3           28.1G     53.5M     26.6G   0% /home/ftp/sdcard
/dev/mmcblk0p3           28.1G     53.5M     26.6G   0% /home/ftp/storage
overlay                  28.1G     53.5M     26.6G   0% /usr
overlay                  28.1G     53.5M     26.6G   0% /var/log
overlay                  28.1G     53.5M     26.6G   0% /var/lib
```
les images de télésurveillance seront stockées dans `/data/machinery/capture`

Pour fonctionner en wifi, il faut créer dans /boot un fichier wireless.conf 

/boot est la partition de 30 Mo

```
update_config=1
ctrl_interface=/var/run/wpa_supplicant

network={
 scan_ssid=1
 ssid=""
 psk=""
}
```
ce fichier est supprimé dès lors que la nouvelle config wifi est mise en oeuvre

pas de shutdown sur l'interface web > lancer la commande `halt`
