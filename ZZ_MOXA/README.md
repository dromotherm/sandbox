
# télécharger les drivers sur le site moxa

https://www.moxa.com/en/support/product-support/software-and-documentation/search?psid=114473

pour connaitre la version de son moyau linux :

```
cat /proc/version
Linux version 5.4.0-77-generic (buildd@lgw01-amd64-021) (gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)) #86~18.04.1-Ubuntu SMP Fri Jun 18 01:23:22 UTC 2021
```

pour pouvoir compiler sur raspbian, il faut préalablement installer les kernel headers :

```
sudo apt-get install raspberrypi-kernel-headers
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following NEW packages will be installed:
  raspberrypi-kernel-headers
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 27.7 MB of archives.
After this operation, 180 MB of additional disk space will be used.
Get:1 http://archive.raspberrypi.org/debian bullseye/main armhf raspberrypi-kernel-headers armhf 1:1.20211118-3 [27.7 MB]
Fetched 27.7 MB in 24s (1,144 kB/s)                                                                                                          
Selecting previously unselected package raspberrypi-kernel-headers.
(Reading database ... 50155 files and directories currently installed.)
Preparing to unpack .../raspberrypi-kernel-headers_1%3a1.20211118-3_armhf.deb ...
Unpacking raspberrypi-kernel-headers (1:1.20211118-3) ...
Setting up raspberrypi-kernel-headers (1:1.20211118-3) ...
```

On télécharge les sources :

```
wget https://cdn-cms.azureedge.net/getmedia/57dfa4c1-8a2a-4da6-84c1-a36944ead74d/moxa-uport-1100-series-linux-kernel-5.x-driver-v5.1.tgz
--2022-02-21 18:37:39--  https://cdn-cms.azureedge.net/getmedia/57dfa4c1-8a2a-4da6-84c1-a36944ead74d/moxa-uport-1100-series-linux-kernel-5.x-driver-v5.1.tgz
Resolving cdn-cms.azureedge.net (cdn-cms.azureedge.net)... 2606:2800:233:1cb7:261b:1f9c:2074:3c, 152.199.21.175
Connecting to cdn-cms.azureedge.net (cdn-cms.azureedge.net)|2606:2800:233:1cb7:261b:1f9c:2074:3c|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 223970 (219K) [application/x-gtar]
Saving to: ‘moxa-uport-1100-series-linux-kernel-5.x-driver-v5.1.tgz’

moxa-uport-1100-ser 100%[===================>] 218.72K   343KB/s    in 0.6s    

2022-02-21 18:37:41 (343 KB/s) - ‘moxa-uport-1100-series-linux-kernel-5.x-driver-v5.1.tgz’ saved [223970/223970]
```
on les décompacte :
```
tar -xvf moxa-uport-1100-series-linux-kernel-5.x-driver-v5.1.tgz mxu11x0/
```
on compile :
```
cd mxu11x0
sudo ./mxinstall 
************************************************************************
 Raspbian GNU/Linux 11 
 \l 5.10.63-v7l+
 MOXA UPort 11x0 series driver ver 5.1
 Release Date: 2021/09/02
************************************************************************
  *******************************************************************
    MOXA UPort 11x0 series USB to Serial Hub Driver v5.1      
                                                                     
                   release date : 2021/09/02                        
  *******************************************************************

Loading driver...
************************************************************************
 MOXA UPort 11x0 series driver ver 5.1 loaded successfully.
************************************************************************
```

# installer setserial

```
sudo apt-get install -y setserial
E: Impossible d'obtenir le verrou /var/lib/dpkg/lock-frontend - open (11: Ressource temporairement non disponible)
E: Impossible d'obtenir le verrou de dpkg (/var/lib/dpkg/lock-frontend). Il est possible qu'un autre processus l'utilise.
```
On supprime les verrous et on relance l'install via apt
```
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock
```
pour passer le port USB0 en RS485 2W :
```
setserial /dev/ttyUSB0 port 1
```
