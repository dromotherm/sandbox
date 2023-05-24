# Extra dockerfile syntax

pour disposer de certains outils en mode interactif :

```
RUN apt-get install -y \
    python3-pip \
    lsb-release \
    iputils-ping \
    net-tools \
    curl \
    wget \
    git \
    nano \
    mosquitto-clients \
    sudo
```
pour cesser d'être root :
```
RUN groupadd pi
RUN useradd -rm -d /home/pi -s /bin/bash -g root -G sudo,dialout -u 1001 pi
USER pi
WORKDIR /home/pi
```
