# Tensorflow
Si on est sur plateforme arm (raspberry), il faut utiliser des wheels et passer par un répertoire tampon

```
cd /var/opt/emoncms
sudo mkdir test
sudo chown $(id -u -n):$(id -u -n) test
cd test
```

v2.1.0 pour buster 32 bits
```
export RELEASE=v2.1.0
export TF=tensorflow-2.1.0-cp37-none-linux_armv7l.whl
```
v2.4.0rc2 pour buster 32 bits
```
export RELEASE=v2.4.0rc2
export TF=tensorflow-2.4.0rc2-cp37-none-linux_armv7l.whl
```
v2.9.0 pour bullseye 64 bits :
```
export RELEASE=v2.9.0
export TF=tensorflow-2.9.0-cp39-none-linux_aarch64.whl
```
on télécharge la wheel et on l'installe avec pip
```
wget https://github.com/dromotherm/sandbox/releases/download/$RELEASE/$TF
TMPDIR=/var/opt/emoncms/test python3 -m pip install --upgrade --no-cache-dir --upgrade $TF
```

un repo avec plus de wheels, dont des versions lite plus légères : https://github.com/PINTO0309/Tensorflow-bin

https://qengineering.eu/

pas besoin de TMPDIR avec les versions lite.....
