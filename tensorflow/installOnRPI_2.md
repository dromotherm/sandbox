on donne un mot de passe à l'user bios
```
sudo passwd bios
```
on crée un répertoire tampon sand /var/opt et on le donne à bios
```
cd /var/opt
sudo mkdir test
sudo chown bios:bios test
```
on lance l'installation du package wheel
```
TMPDIR=/var/opt/test pip3 install --cache-dir=/var/opt/test --build /var/opt/test --upgrade https://storage.googleapis.com/tensorflow/raspberrypi/tensorflow-2.3.0-cp35-none-linux_armv7l.whl
```
