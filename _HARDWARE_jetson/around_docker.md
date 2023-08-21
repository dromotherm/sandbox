pour manager ses images :
```
sudo docker images
sudo docker container prune
sudo docker system prune
```

pour voir les containers arrêtés :

```
docker ps -a
```

Pour manager les networks docker :
```
docker network ls
docker network inspect xxxxx
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

# pour cesser d'être root dans l'image
```
RUN groupadd pi
RUN useradd -rm -d /home/pi -s /bin/bash -g root -G sudo,dialout -u 1001 pi
USER pi
WORKDIR /home/pi
```
# démarrer des containers automatiquement

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

le mieux est d'installer docker compose


