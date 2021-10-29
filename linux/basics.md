# OS version
```
cat /etc/os-release
```

# Voir le partionnement du disque dur

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
```
uname -m
armv7l
```

Pour trouver le bash :

```
which bash
bin/bash
```
