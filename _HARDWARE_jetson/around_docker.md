Pour manager ses images :
```
sudo docker images
sudo docker system prune
```
Pour arrêter tous ses containers actifs : `sudo docker stop $(sudo docker ps -a -q)` ou `docker stop $(docker ps -a -q)`

Pour voir les containers arrêtés : `docker ps -a`

On peut ensuite redémarrer un conteneur arrêté avec `docker run <id>`

Pour supprimer tous les containers arrêtés : `sudo docker container prune`

Pour manager les networks docker :
```
docker network ls
docker network inspect xxxxx
```
# les logs

Pour gérer la taille et la rotation des logs, on crée un fichier `daemon.json` dans `/ect/docker` :
```
nano /etc/docker/daemon.json
```
on y met le contenu suivant :
```
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "3m",
    "max-file": "3",
    "labels": "production_status",
    "env": "os,customer"
  }
}
```
Et on relance le docker daemon : `sudo systemctl restart docker`

Les logs sont dans `/var/lib/docker/containers`

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
