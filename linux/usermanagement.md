# users management on Linux Debian/Raspbian

**a good choice is to run the service with a dedicated user, so basic knowledge on user management is essential**

il y a plusieurs commandes  `useradd` et `adduser`

## useradd

pour créer un utilisateur avec des privilèges particuliers sur le port série : 
```
sudo useradd -M -r -G dialout,tty -c "emonHub user" emonhub
```
ajouter un user comme sudoer
```
sudo useradd -G sudo savine
```
Si l'utilisateur est existant : 
```
sudo usermod -a -G dialout,tty alexandrecuer
```
## adduser
```
sudo adduser alexandrecuer dialout
```
Pour donner à un user les privilèges sudoers
```
sudo adduser bios sudo
```
## list users and groups

pour lister les groupes et les utilisateurs qu'ils contiennent :
```
cat /etc/group
```
List all users and groups
```
cat /etc/passwd | awk -F: '{print $ 1}'
cat /etc/group | awk -F: '{print $ 1}'
```
list sudoers
```
grep "sudo" /etc/group
```
pour savoir si un user dispose des privilèges sudoer :
```
sudo -l -U bios
```

## deluser

pour enlever un utilisateur de la liste des sudoers, ie du groupe sudo :
```
sudo deluser bios sudo
```
Une fois l'utilisateur enlevé de la liste des sudoers, on obtient ainsi la sortie suivante lorsqu'on vérifie s'il dispose des privilèges sudoer :
```
sudo -l -U bios
L'utilisateur bios n'est pas autorisé à exécuter sudo sur
        alexandrecuer-PORTEGE-R30-A.
```
## change password user pi:
```
sudo passwd pi
```



## pour ajouter un répertoire dans le path

içi celui de platformio :
```
cd ~
nano .profile
```
a la fin, on rajoute la ligne suivante :

```
PATH=$PATH:/home/pi/.platformio/penv/bin
```
