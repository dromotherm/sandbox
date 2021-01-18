dist-packages is a Debian-specific convention that is also present in its derivatives, like Ubuntu. 
Modules are installed to dist-packages when they come from the Debian package manager (apt-get)

# global packages/modules

`python3 -m site`

output example :
```
sys.path = [
    '/opt/openenergymonitor/BIOS',
    '/usr/lib/python37.zip',
    '/usr/lib/python3.7',
    '/usr/lib/python3.7/lib-dynload',
    '/home/pi/.local/lib/python3.7/site-packages',
    '/usr/local/lib/python3.7/dist-packages',
    '/usr/lib/python3/dist-packages',
]
USER_BASE: '/home/pi/.local' (exists)
USER_SITE: '/home/pi/.local/lib/python3.7/site-packages' (exists)
ENABLE_USER_SITE: True
```

global packages are in `/usr/lib/python3/dist-packages`

# user packages

`python3 -m site --user-site`

output : `/home/pi/.local/lib/python3.7/site-packages`

`pip3 list --user` gives you a list of all installed per user site-packages

you will find the same user packages by browsing : `cd /home/pi/.local/lib/python3.7/site-packages`

# tracking packages

run `pip3 list`

```
pip3 show numpy| grep Location
Location: /usr/lib/python3/dist-packages
```
```
pip3 show python-dateutil| grep Location
Location: /home/pi/.local/lib/python3.7/site-packages
```
numpy is a global package : it has been installed through apt-get 

dateutil is a user package, installed via pip3. On some platforms, it is installed as a global package, on many, it is only installed locally.

what is possible is the following, although not very nice and specific to debian !!!

```
sudo mv /home/pi/.local/lib/python3.7/site-packages/dateutil /usr/lib/python3/dist-packages/dateutil
sudo mv /home/pi/.local/lib/python3.7/site-packages/python_dateutil-2.8.1.dist-info /usr/lib/python3/dist-packages/python_dateutil-2.8.1.dist-info
```

same for redis-py
```
ls -al /home/pi/.local/lib/python3.7/site-packages
total 44
drwx------ 6 pi pi  4096 Oct  6 17:24 .
drwxr-xr-x 3 pi pi  4096 Aug 29 16:54 ..
drwxr-xr-x 2 pi pi  4096 Aug 29 16:54 __pycache__
drwxr-xr-x 3 pi pi  4096 Aug 29 16:54 redis
drwxr-xr-x 2 pi pi  4096 Aug 29 16:54 redis-3.5.3.dist-info
drwxr-xr-x 2 pi pi  4096 Aug 29 16:54 xmltodict-0.12.0.dist-info
-rw-r--r-- 1 pi pi 17406 Aug 29 16:54 xmltodict.py
```
so we have to simply do :
```
sudo mv /home/pi/.local/lib/python3.7/site-packages/redis /usr/lib/python3/dist-packages/redis
sudo mv /home/pi/.local/lib/python3.7/site-packages/redis-3.5.3.dist-info /usr/lib/python3/dist-packages/redis-3.5.3.dist-info
```
same for pymodbus :

```
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/pymodbus /usr/lib/python3/dist-packages/pymodbus
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/pymodbus-2.4.0.dist-info /usr/lib/python3/dist-packages/pymodbus-2.4.0.dist-info
```
# tensorflow2.1.0

tried the following commands to transform a tensorflow user installation into a system wide install, with no succes 
```
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/tensorflow /usr/lib/python3/dist-packages/tensorflow
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/tensorflow-2.1.0.dist-info /usr/lib/python3/dist-packages/tensorflow-2.1.0.dist-info
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/tensorflow_core /usr/lib/python3/dist-packages/tensorflow_core
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/tensorflow_estimator /usr/lib/python3/dist-packages/tensorflow_estimator
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/tensorflow_estimator-2.1.0.dist-info /usr/lib/python3/dist-packages/tensorflow_estimator-2.1.0.dist-info
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/tensorboard /usr/lib/python3/dist-packages/tensorboard
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/tensorboard-2.1.0.dist-info /usr/lib/python3/dist-packages/tensorboard-2.1.0.dist-info

sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/keras /usr/lib/python3/dist-packages/keras
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/Keras-2.3.1.dist-info /usr/lib/python3/dist-packages/Keras-2.3.1.dist-info
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/keras_applications /usr/lib/python3/dist-packages/keras_applications
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/Keras_Applications-1.0.8.dist-info /usr/lib/python3/dist-packages/Keras_Applications-1.0.8.dist-info
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/keras_preprocessing /usr/lib/python3/dist-packages/keras_preprocessing
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/Keras_Preprocessing-1.1.0.dist-info /usr/lib/python3/dist-packages/Keras_Preprocessing-1.1.0.dist-info

sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/protobuf-3.11.2.dist-info /usr/lib/python3/dist-packages/protobuf-3.11.2.dist-info
```
to solve a numpy compatibility problem (tf was said to be compiled with 3.x and having only 2.x
```
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/numpy /usr/lib/python3/dist-packages/numpy
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/numpy-1.18.1.dist-info /usr/lib/python3/dist-packages/numpy-1.18.1.dist-info
```
so decided to install tf on the bios user
```
python3 -m pip install --upgrade setuptools pip
Collecting setuptools
  Using cached https://files.pythonhosted.org/packages/b2/81/509db0082c0d2ca2af307c6652ea422865de1f83c14b1e1f3549e415cfac/setuptools-51.3.3-py3-none-any.whl
Collecting pip
  Cache entry deserialization failed, entry ignored
  Downloading https://files.pythonhosted.org/packages/54/eb/4a3642e971f404d69d4f6fa3885559d67562801b99d7592487f1ecc4e017/pip-20.3.3-py2.py3-none-any.whl (1.5MB)
    100% |████████████████████████████████| 1.5MB 358kB/s 
Installing collected packages: setuptools, pip
Successfully installed pip-20.3.3 setuptools-51.3.3
$ pip3 --version
WARNING: pip is being invoked by an old script wrapper. This will fail in a future version of pip.
Please see https://github.com/pypa/pip/issues/5599 for advice on fixing the underlying issue.
To avoid this problem you can invoke Python with '-m pip' instead of running pip directly.
pip 20.3.3 from /home/bios/.local/lib/python3.6/site-packages/pip (python 3.6)
```
