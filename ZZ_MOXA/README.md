
# télécharger les drivers sur le site moxa

https://www.moxa.com/en/support/product-support/software-and-documentation/search?psid=114473

pour connaitre la version de son moyau linux :

```
cat /proc/version
Linux version 5.4.0-77-generic (buildd@lgw01-amd64-021) (gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)) #86~18.04.1-Ubuntu SMP Fri Jun 18 01:23:22 UTC 2021
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
