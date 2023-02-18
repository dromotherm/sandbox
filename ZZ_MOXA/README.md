alternative download :
```
wget https://raw.githubusercontent.com/dromotherm/sandbox/master/ZZ_MOXA/driv_linux_uport1p_v5.1.5_build_22053114.tgz
```

# Bios avec prise en compte des drivers MOXA

**ne fonctionne pas - les drivers linux ne sont jamais à jour. il y a tjrs un problème avec les kernel headers**

2 options :
1) relancer le support moxa à chaque fois que le build ne fonctionne pas
2) comprendre le code du driver

Les 2 options demandent trop de temps
```
sudo apt-get update
sudo apt install git bc bison flex libssl-dev
sudo apt-get install raspberrypi-kernel-headers
sudo apt-get install -y git build-essential python3-pip python3-dev
wget https://raw.githubusercontent.com/dromotherm/sandbox/master/ZZ_MOXA/driv_linux_uport1p_v5.1.5_build_22053114.tgz
tar -xvf driv_linux_uport1p_v5.1.5_build_22053114.tgz
cd ./mxu11x0/
sudo ./mxinstall
```

# compiler les drivers moxa

https://www.moxa.com/en/support/product-support/software-and-documentation/search?psid=114473

pour connaitre la version de son noyau linux :

```
cat /proc/version
Linux version 5.4.0-77-generic (buildd@lgw01-amd64-021) (gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)) #86~18.04.1-Ubuntu SMP Fri Jun 18 01:23:22 UTC 2021
```

pour pouvoir compiler sur raspbian, il faut préalablement installer les kernel headers :

```
sudo apt install git bc bison flex libssl-dev
sudo apt-get install raspberrypi-kernel-headers
```

## option 1 : depuis le site officiel de moxa :

On télécharge les sources :

```
wget https://cdn-cms.azureedge.net/getmedia/57dfa4c1-8a2a-4da6-84c1-a36944ead74d/moxa-uport-1100-series-linux-kernel-5.x-driver-v5.1.tgz
```
on les décompacte :
```
tar -xvf moxa-uport-1100-series-linux-kernel-5.x-driver-v5.1.tgz mxu11x0/
```
## option 2 : depuis le répertoire github de Moxa

non testé :
```
git clone http://github.com/Moxa-Linux/mxu11x0
```
## compilation

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
