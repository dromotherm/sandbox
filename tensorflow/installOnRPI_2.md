on donne un mot de passe à l'user bios
```
sudo passwd bios
```
on crée un répertoire tampon dans /var/opt/emoncms et on le donne à bios
```
cd /var/opt/emoncms
sudo mkdir test
sudo chown bios:bios test
sudo mkdir /home/bios
sudo chown bios:bios /home/bios
```
on lance l'installation du package wheel
```
TMPDIR=/var/opt/test pip3 install --cache-dir=/var/opt/test --build /var/opt/test --upgrade https://storage.googleapis.com/tensorflow/raspberrypi/tensorflow-2.3.0-cp35-none-linux_armv7l.whl
```

celui de tensorflow n'est pas reconnu ?
```
TMPDIR=/var/opt/test pip3 install --cache-dir=/var/opt/test --build /var/opt/test --upgrade https://github.com/lhelontra/tensorflow-on-arm/releases/download/v2.1.0/tensorflow-2.1.0-cp37-none-linux_armv7l.whl
```
