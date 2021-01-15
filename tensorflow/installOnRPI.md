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

if h5py module is not installed, tnesorflow will not be able to open pretrained model saved as a h5 file :

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
Anyway, the above command is installing version 3.1.0 which is not suitable on a RPI. 

When opening a h5 model :
```
AttributeError: 'str' object has no attribute 'decode'
```
Decision to install version 2.10.0 is correct :
```
pip install h5py==2.10.0
```
Nota : the 2.10.0 version is not available via apt-get 
```
sudo apt-get install python3-h5py=2.10.0
```
