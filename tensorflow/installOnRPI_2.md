# check and prepare
```
cat /etc/os-release
PRETTY_NAME="Raspbian GNU/Linux 10 (buster)"
NAME="Raspbian GNU/Linux"
VERSION_ID="10"
VERSION="10 (buster)"
VERSION_CODENAME=buster
ID=raspbian
ID_LIKE=debian
HOME_URL="http://www.raspbian.org/"
SUPPORT_URL="http://www.raspbian.org/RaspbianForums"
BUG_REPORT_URL="http://www.raspbian.org/RaspbianBugs"
```
update : `sudo apt update`
```
pip3 --version
pip 18.1 from /usr/lib/python3/dist-packages/pip (python 3.7)
```
```
sudo apt install python3-dev python3-pip python3-venv
Reading package lists... Done
Building dependency tree       
Reading state information... Done
python3-dev is already the newest version (3.7.3-1).
python3-dev set to manually installed.
python3-pip is already the newest version (18.1-5+rpt1).
The following additional packages will be installed:
  python3.7-venv
The following NEW packages will be installed:
  python3-venv python3.7-venv
0 upgraded, 2 newly installed, 0 to remove and 72 not upgraded.
Need to get 7,328 B of archives.
After this operation, 44.0 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:2 http://raspbian.raspberrypi.org/raspbian buster/main armhf python3-venv armhf 3.7.3-1 [1,180 B]
Get:1 http://mirrors.ircam.fr/pub/raspbian/raspbian buster/main armhf python3.7-venv armhf 3.7.3-2+deb10u2 [6,148 B]
Fetched 7,328 B in 0s (19.0 kB/s)    
Selecting previously unselected package python3.7-venv.
(Reading database ... 54490 files and directories currently installed.)
Preparing to unpack .../python3.7-venv_3.7.3-2+deb10u2_armhf.deb ...
Unpacking python3.7-venv (3.7.3-2+deb10u2) ...
Selecting previously unselected package python3-venv.
Preparing to unpack .../python3-venv_3.7.3-1_armhf.deb ...
Unpacking python3-venv (3.7.3-1) ...
Setting up python3.7-venv (3.7.3-2+deb10u2) ...
Setting up python3-venv (3.7.3-1) ...
Processing triggers for man-db (2.8.5-2) ...
```
# very important if the wheel comes from piwheels and not from pypi
```
sudo apt install libatlas-base-dev
```
# install with the wheel package

You must have a certain knowledge of the architecture `uname -m`

the answer should be `armv7l` ou `armv8`.

ARMv7 or under = 32 bit.

64 bit starts with AMRv8.

there is a tflite package for the RPI
https://www.tensorflow.org/lite/guide/python
But the model should have been saved or converted as a tflite model !

See :
https://github.com/lhelontra/tensorflow-on-arm

```
cd /var/opt
sudo mkdir test
sudo chown pi:pi test
TMPDIR=/var/opt/test pip3 install --cache-dir=/var/opt/test --build /var/opt/test --upgrade https://github.com/lhelontra/tensorflow-on-arm/releases/download/v2.1.0/tensorflow-2.1.0-cp37-none-linux_armv7l.whl
TMPDIR=/var/opt/test pip3 install --cache-dir=/var/opt/test --build /var/opt/test --upgrade https://github.com/lhelontra/tensorflow-on-arm/releases/download/v2.4.0/tensorflow-2.4.0-cp37-none-linux_armv7l.whl
```

NOTA : the --build option is no more available

what is important if you dont have enough space on your root is TMPDIR. you can use --no-cache-dir.

# uninstall

to uninstall :
```
TMPDIR=/var/opt/test pip3 uninstall --cache-dir=/var/opt/test tensorboard 
Uninstalling tensorboard-2.0.2:
  Would remove:
    /home/pi/.local/lib/python3.7/site-packages/tensorboard-2.0.2.dist-info/*
    /home/pi/.local/lib/python3.7/site-packages/tensorboard/*
Proceed (y/n)? y
  Successfully uninstalled tensorboard-2.0.2
```

same with tensorflow or tensorflow-estimator

# support for h5 files

if h5py module is not installed, tensorflow will not be able to open pretrained model saved as a h5 file :

```
Traceback (most recent call last):
  File "test.py", line 3, in <module>
    agent = tf.keras.models.load_model(name)
  File "/home/pi/.local/lib/python3.7/site-packages/tensorflow_core/python/keras/saving/save.py", line 149, in load_model
    loader_impl.parse_saved_model(filepath)
  File "/home/pi/.local/lib/python3.7/site-packages/tensorflow_core/python/saved_model/loader_impl.py", line 83, in parse_saved_model
    constants.SAVED_MODEL_FILENAME_PB))
OSError: SavedModel file does not exist at: 4parsChh.h5/{saved_model.pbtxt|saved_model.pb}

```
The module should be available via apt :
```
sudo apt-get install python3-h5py
```
Anyway, the above command installs version 3.1.0 which is not suitable on a RPI. 

When opening a h5 model :
```
AttributeError: 'str' object has no attribute 'decode'
```
Decision to install version 2.10.0 is correct :
```
pip install h5py==2.10.0
```
cf https://stackoverflow.com/questions/53740577/does-any-one-got-attributeerror-str-object-has-no-attribute-decode-whi

cf https://github.com/tensorflow/tensorflow/issues/44467

Nota : the 2.10.0 version is not available via apt-get 
```
sudo apt-get install python3-h5py=2.10.0
```
## EDIT :
si on a la version 3.4.0 de h5py
```
python3 -m pip list
Package                Version
---------------------- ---------
absl-py                0.13.0
asn1crypto             0.24.0
astor                  0.8.1
attrs                  18.2.0
Automat                0.6.0
cached-property        1.5.2
cachetools             4.2.2
certifi                2018.8.24
chardet                3.0.4
Click                  7.0
colorama               0.3.7
colorzero              1.1
configobj              5.0.6
constantly             15.1.0
cryptography           2.6.1
entrypoints            0.3
gast                   0.2.2
google-auth            1.35.0
google-auth-oauthlib   0.4.5
google-pasta           0.2.0
gpiozero               1.6.2
grpcio                 1.39.0
h5py                   3.4.0
hyperlink              17.3.1
idna                   2.6
importlib-metadata     4.8.1
incremental            16.10.1
Keras-Applications     1.0.8
Keras-Preprocessing    1.1.2
keyring                17.1.1
keyrings.alt           3.1.1
Markdown               3.3.4
minimalmodbus          2.0.1
mysql-connector-python 8.0.15
numpy                  1.16.2
oauthlib               3.1.1
opt-einsum             3.3.0
paho-mqtt              1.5.1
pip                    21.2.4
protobuf               3.17.3
py-sds011              0.9
pyasn1                 0.4.2
pyasn1-modules         0.2.1
PyBluez                0.23
pycrypto               2.6.1
PyGObject              3.30.4
pymodbus               2.5.2
pyOpenSSL              19.0.0
pyserial               3.4
pyserial-asyncio       0.4
python-apt             1.8.4.3
pyxdg                  0.25
redis                  3.5.3
requests               2.21.0
requests-oauthlib      1.3.0
RPi.GPIO               0.7.0
rsa                    4.7.2
scipy                  1.4.1
sdm-modbus             0.4.6
SecretStorage          2.3.1
service-identity       16.0.0
setuptools             57.4.0
six                    1.16.0
spidev                 3.5
ssh-import-id          5.7
tensorboard            2.1.1
tensorflow             2.1.0
tensorflow-estimator   2.1.0
termcolor              1.1.0
Twisted                18.9.0
typing-extensions      3.10.0.1
urllib3                1.24.1
Werkzeug               2.0.1
wheel                  0.32.3
wrapt                  1.12.1
xmltodict              0.12.0
zipp                   3.5.0
zope.interface         4.3.2
```
il faut le désinstaller
```
pip3 uninstall h5py
Found existing installation: h5py 3.4.0
Uninstalling h5py-3.4.0:
  Would remove:
    /home/pi/.local/lib/python3.7/site-packages/h5py-3.4.0.dist-info/*
    /home/pi/.local/lib/python3.7/site-packages/h5py/*
Proceed (Y/n)? y
  Successfully uninstalled h5py-3.4.0
```
puis installer h5py via apt :
```
sudo apt-get install python3-h5py
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following package was automatically installed and is no longer required:
  python-colorzero
Use 'sudo apt autoremove' to remove it.
Suggested packages:
  python-h5py-doc
The following NEW packages will be installed:
  python3-h5py
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 809 kB of archives.
After this operation, 5,599 kB of additional disk space will be used.
Get:1 http://mirrors.ircam.fr/pub/raspbian/raspbian buster/main armhf python3-h5py armhf 2.8.0-3 [809 kB]
Fetched 809 kB in 3s (277 kB/s)       
Selecting previously unselected package python3-h5py.
(Reading database ... 49322 files and directories currently installed.)
Preparing to unpack .../python3-h5py_2.8.0-3_armhf.deb ...
Unpacking python3-h5py (2.8.0-3) ...
Setting up python3-h5py (2.8.0-3) ...
```
