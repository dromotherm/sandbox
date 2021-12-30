pour vérifier l'état des connections au serveur :
```
netstat
netstat -6 -W -c
```

# IP fixe

sur un vieux pi :
```
sudo rpi-rw
sudo nano /etc/network/interfaces
```
pour passer de ip fixe à dhcp :
```
auto lo
iface lo inet loopback
iface eth0 inet dhcp
```
on commente les lignes du type :
```
#address 192.168.1.32
#netmask 255.255.255.0
#gateway 192.168.1.1
```
pour activer :
```
sudo ifdown eth0; ifup eth0
```
