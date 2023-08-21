# recherches pour faire fonctionner les drivers CH341

juste pour la culture générale

remove nvgetty

https://github.com/JetsonHacksNano/UARTDemo/blob/master/README.md


CONFIG_USB_SERIAL_CH341 must be set in /proc/config.gz

```
sudo apt remove brltty
```

des répertoires avec des sources de drivers CH341 modifiées

https://github.com/juliagoda/CH341SER

https://github.com/aperepel/raspberrypi-ch340-driver

https://github.com/skyrocknroll/CH341SER_LINUX

# install de la stack emoncms

https://github.com/emoncms/emoncms/issues/1726

https://github.com/dromotherm/sandbox/tree/master/bios

# python 3.8

pour faire fonctionner pymodbus, il faut avoir python3.8. Pas la peine de passer à Ubuntu20 rien que pour celà, on va juste créer un environnement virtuel

```
sudo apt-get install python3.8 python3.8-dev python3.8-distutils python3.8-venv
sudo mkdir /opt/v
sudo chown $(id -u -n):$(id -u -n) /opt/v
python3.8 -m venv /opt/v/bios
cd /opt/v/bios/bin/
source activate
python3 -m pip install pip --upgrade
python3 -m pip install pyserial
python3 -m pip install mysql-connector-python
python3 -m pip install paho-mqtt
python3 -m pip install pymodbus
```
Cette astuce permettra de faire fonctionner les service ota2 et modbus sans problème, mais pas bios qui a besoin de tensorflow

## tensorflow

sous ubuntu18.04, même la version lite ne fonctionne pas avec python3.8

```
python3
Python 3.8.16 (default, Dec  7 2022, 01:12:13) 
[GCC 7.5.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import tflite_runtime.interpreter as tflite
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "/opt/v/bios/lib/python3.8/site-packages/tflite_runtime/interpreter.py", line 34, in <module>
    from tflite_runtime import _pywrap_tensorflow_interpreter_wrapper as _interpreter_wrapper
ImportError: /lib/aarch64-linux-gnu/libc.so.6: version `GLIBC_2.28' not found (required by /opt/v/bios/lib/python3.8/site-packages/tflite_runtime/_pywrap_tensorflow_interpreter_wrapper.so)
```
cf https://stackoverflow.com/questions/847179/multiple-glibc-libraries-on-a-single-host

on a donc testé une solution avec un container docker

# container docker pour BIOS

on a commencé par le service modbus pour faire un essai simple

A noter qu'en mode exploitation, il y a peu de chance qu'on utilise le service modbus, car tout est géré par le service bios vu qu'on a besoin d'un lock pour synchroniser les choses entre les périphériques modbus de monitoring et les périphériques modbus de pilotage

on crée sur la machine hôte les répertoires de conf et de log sauf si on a déjà installé un autre service comme ota2 de façon classique

```
sudo mkdir /etc/bios
sudo mkdir /var/log/bios
```

on crée un fichier Dockerfile de ce type :
```
FROM ubuntu:20.04

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install tzdata -y
ENV TZ="Europe/Paris"

RUN apt-get install -y python3.8 \
    python3-pip \
    python3.8-dev \
    python3.8-distutils \
    python3.8-venv

RUN mkdir /opt/v
ENV VIRTUAL_ENV=/opt/v/bios
RUN python3.8 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN python3 -m pip install pip --upgrade
RUN python3 -m pip install pyserial
#RUN python3 -m pip install mysql-connector-python
RUN python3 -m pip install paho-mqtt
RUN python3 -m pip install pymodbus
#RUN python3 -m pip install click

ADD BIOS2 /opt/BIOS2
WORKDIR /opt/BIOS2/hardware

CMD ["python3", "modbus.py", "--conf=/etc/bios/modbus.conf", "--log=/var/log/bios/modbus.log"]
```
on a utilisé un venv

cf https://pythonspeed.com/articles/activate-virtualenv-dockerfile/

on construit l'image et on la teste en la démarrant en mode interactif :

```
sudo docker pull ubuntu:20.04
sudo docker build -t biosdocker .
sudo docker run --network host --privileged --rm -v /etc/bios:/etc/bios -v /var/log/bios:/var/log/bios -v /dev:/dev -it biosdocker
sudo docker run --net=host --rm --privileged -v /etc/bios:/etc/bios -v /var/log/bios:/var/log/bios -v /dev:/dev -it biosdocker
```

le flag `--net=host` ou `--network host` permet de pouvoir utiliser localhost et donc :
- de publier sur le broker de la machine hôte, 
- ou de lire/écrire sur le serveur redis de la machine hôte.

On dit qu'on est en mode host networking

cf https://docs.docker.com/network/network-tutorial-host/

les flags `--privileged` et `-v /dev:/dev` permettent d'accéder aux ports usb depuis le container

https://stackoverflow.com/questions/24225647/docker-a-way-to-give-access-to-a-host-usb-or-serial-device

https://stackoverflow.com/questions/33013539/docker-loading-kernel-modules

L'option priviledged n'est pas recommandée mais si on ne l'utilise pas, on a ce genre d'erreur :
```
[Errno 1] could not open port /dev/ttyUSB0
```
