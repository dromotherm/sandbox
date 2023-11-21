**many IA jetson docker images :**
https://github.com/dusty-nv/jetson-containers/tree/master

https://blog.appsecco.com/top-10-docker-hardening-best-practices-f16c090e4d59

# gestion des containers et des images

Pour lister les images :
```
sudo docker images
sudo docker image ls
```
Remove all unused containers, networks, images (both dangling and unreferenced), and optionally, volumes
```
sudo docker system prune
```
Pour arrêter tous ses containers actifs : `sudo docker stop $(sudo docker ps -a -q)` ou `docker stop $(docker ps -a -q)`

Lister les containers actifs: `docker ps`

Pour voir même les containers arrêtés : `docker ps -a`

On peut ensuite redémarrer un conteneur arrêté avec `docker run <id>`

Pour supprimer tous les containers arrêtés : `sudo docker container prune`

Pour manager les networks docker :
```
docker network ls
docker network inspect xxxxx
```
# emplacement des données docker sur le disque
```
docker info
docker info | grep -e "Root Dir"
Docker Root Dir: /var/lib/docker
```
les images sont dans /var/lib/docker

pour connaître l'espace occupé par docker et ses images
```
sudo du -c /var/lib/docker
```

# sur debian, pour disposer de certains outils en mode interactif

```
RUN apt-get install -y \
    python3-pip \
    lsb-release \
    usbutils \
    iputils-ping \
    net-tools \
    curl \
    wget \
    git \
    nano \
    mosquitto-clients \
    sudo
```
le package usbutils permet d'utiliser lsusb

le package mosquitto-clients permet d'utiliser mosquitto_pub

Attention, tout ceci ne sert que pour des tests, sur les images finales, pour éviter de gaspiller de la place, si on a besoin de certains outils dans un RUN en particulier, on les installe au début, on fait ce qu'on a faire avec, puis on les désinstalle

# pour cesser d'être root au cours du build de l'image
```
RUN groupadd pi
RUN useradd -rm -d /home/pi -s /bin/bash -g root -G sudo,dialout -u 1001 pi
USER pi
WORKDIR /home/pi
```
# démarrer des containers automatiquement

## en utilisant un process manager

https://docs.docker.com/config/containers/start-containers-automatically/

exemple de service file :
```
[Unit]
Description=modbus
Wants=systemd-timesyncd.service
After=docker.service systemd-timesyncd.service
Requires=docker.service

[Service]
ExecStart=/usr/bin/docker run --net=host --rm --privileged -v /etc/bios:/etc/bios -v /var/log/bios:/var/log/bios -v /dev:/dev biosdocker
Type=exec
Restart=always
RestartSec=5

[Install]
WantedBy=default.target
```
## avec les restart policies

le mieux est d'installer docker-compose

http://github.com/docker/compose

on télécharge l'exécutable qui va bien dans https://github.com/docker/compose/releases

- on renomme ce fichier en `docker-compose`
- on le rend exécutable par `chmod +x docker-compose`
- on le copie colle dans `/bin` : `sudo cp docker-compose /bin/docker-compose`

on crée un fichier compose avec pour chaque service `restart: always` ou `restart: unless-stopped`

Puis on lance `docker-compose up -d`

# compose.yaml

https://github.com/docker/compose/issues/8154

https://medium.com/weekly-webtips/control-startup-and-shutdown-order-of-containers-in-docker-compose-ff7320f868e2

https://docs.docker.com/compose/startup-order/

https://docs.docker.com/compose/compose-file/05-services/
search for health
