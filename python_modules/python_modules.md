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
# tensorflow

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
to solve a numpy compatibility problem, as tf was said to be compiled with 3.x and having only 2.x :
```
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/numpy /usr/lib/python3/dist-packages/numpy
sudo mv /home/alexandrecuer/.local/lib/python3.6/site-packages/numpy-1.18.1.dist-info /usr/lib/python3/dist-packages/numpy-1.18.1.dist-info
```
>> decided to install tensorflow for the bios user....

Once logged, check pip3 version :
```
$ pip3 --version
pip 9.0.1 from /usr/lib/python3/dist-packages (python 3.6)
$ pip --version
pip 20.0.2 from /usr/local/lib/python2.7/dist-packages/pip (python 2.7)
```
>> we have to upgrade pip3 :

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
```
pip3 should be uptodate :
```
$ pip3 --version
WARNING: pip is being invoked by an old script wrapper. This will fail in a future version of pip.
Please see https://github.com/pypa/pip/issues/5599 for advice on fixing the underlying issue.
To avoid this problem you can invoke Python with '-m pip' instead of running pip directly.
pip 20.3.3 from /home/bios/.local/lib/python3.6/site-packages/pip (python 3.6)
```
launch tensorflow installation via pip3

```
pip3 install --upgrade tensorflow
```
The return should be something like that :
```
WARNING: pip is being invoked by an old script wrapper. This will fail in a future version of pip.
Please see https://github.com/pypa/pip/issues/5599 for advice on fixing the underlying issue.
To avoid this problem you can invoke Python with '-m pip' instead of running pip directly.
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: tensorflow in /home/bios/.local/lib/python3.6/site-packages (1.14.0)
Collecting tensorflow
  Downloading tensorflow-2.4.0-cp36-cp36m-manylinux2010_x86_64.whl (394.7 MB)
     |████████████████████████████████| 394.7 MB 3.4 kB/s 
Requirement already satisfied: typing-extensions~=3.7.4 in /home/bios/.local/lib/python3.6/site-packages (from tensorflow) (3.7.4.3)
Requirement already satisfied: google-pasta~=0.2 in /home/bios/.local/lib/python3.6/site-packages (from tensorflow) (0.2.0)
Requirement already satisfied: absl-py~=0.10 in /home/bios/.local/lib/python3.6/site-packages (from tensorflow) (0.11.0)
Requirement already satisfied: termcolor~=1.1.0 in /home/bios/.local/lib/python3.6/site-packages (from tensorflow) (1.1.0)
Requirement already satisfied: numpy~=1.19.2 in /home/bios/.local/lib/python3.6/site-packages (from tensorflow) (1.19.5)
Requirement already satisfied: keras-preprocessing~=1.1.2 in /home/bios/.local/lib/python3.6/site-packages (from tensorflow) (1.1.2)
Requirement already satisfied: wheel~=0.35 in /home/bios/.local/lib/python3.6/site-packages (from tensorflow) (0.36.2)
Requirement already satisfied: opt-einsum~=3.3.0 in /usr/local/lib/python3.6/dist-packages (from tensorflow) (3.3.0)
Requirement already satisfied: six~=1.15.0 in /home/bios/.local/lib/python3.6/site-packages (from tensorflow) (1.15.0)
Requirement already satisfied: protobuf>=3.9.2 in /home/bios/.local/lib/python3.6/site-packages (from tensorflow) (3.14.0)
Requirement already satisfied: wrapt~=1.12.1 in /home/bios/.local/lib/python3.6/site-packages (from tensorflow) (1.12.1)
Collecting gast==0.3.3
  Downloading gast-0.3.3-py2.py3-none-any.whl (9.7 kB)
Collecting astunparse~=1.6.3
  Downloading astunparse-1.6.3-py2.py3-none-any.whl (12 kB)
Collecting flatbuffers~=1.12.0
  Downloading flatbuffers-1.12-py2.py3-none-any.whl (15 kB)
Collecting grpcio~=1.32.0
  Downloading grpcio-1.32.0-cp36-cp36m-manylinux2014_x86_64.whl (3.8 MB)
     |████████████████████████████████| 3.8 MB 576 kB/s 
Collecting h5py~=2.10.0
  Downloading h5py-2.10.0-cp36-cp36m-manylinux1_x86_64.whl (2.9 MB)
     |████████████████████████████████| 2.9 MB 52 kB/s 
Collecting tensorboard~=2.4
  Downloading tensorboard-2.4.1-py3-none-any.whl (10.6 MB)
     |████████████████████████████████| 10.6 MB 83 kB/s 
Requirement already satisfied: requests<3,>=2.21.0 in /usr/local/lib/python3.6/dist-packages (from tensorboard~=2.4->tensorflow) (2.25.1)
Requirement already satisfied: markdown>=2.6.8 in /home/bios/.local/lib/python3.6/site-packages (from tensorboard~=2.4->tensorflow) (3.3.3)
Requirement already satisfied: setuptools>=41.0.0 in /home/bios/.local/lib/python3.6/site-packages (from tensorboard~=2.4->tensorflow) (51.3.3)
Requirement already satisfied: werkzeug>=0.11.15 in /home/bios/.local/lib/python3.6/site-packages (from tensorboard~=2.4->tensorflow) (1.0.1)
Requirement already satisfied: google-auth<2,>=1.6.3 in /usr/local/lib/python3.6/dist-packages (from tensorboard~=2.4->tensorflow) (1.24.0)
Requirement already satisfied: google-auth-oauthlib<0.5,>=0.4.1 in /usr/local/lib/python3.6/dist-packages (from tensorboard~=2.4->tensorflow) (0.4.2)
Requirement already satisfied: cachetools<5.0,>=2.0.0 in /usr/local/lib/python3.6/dist-packages (from google-auth<2,>=1.6.3->tensorboard~=2.4->tensorflow) (4.2.0)
Requirement already satisfied: rsa<5,>=3.1.4 in /usr/local/lib/python3.6/dist-packages (from google-auth<2,>=1.6.3->tensorboard~=2.4->tensorflow) (4.7)
Requirement already satisfied: pyasn1-modules>=0.2.1 in /usr/local/lib/python3.6/dist-packages (from google-auth<2,>=1.6.3->tensorboard~=2.4->tensorflow) (0.2.8)
Requirement already satisfied: requests-oauthlib>=0.7.0 in /usr/local/lib/python3.6/dist-packages (from google-auth-oauthlib<0.5,>=0.4.1->tensorboard~=2.4->tensorflow) (1.3.0)
Requirement already satisfied: importlib-metadata in /home/bios/.local/lib/python3.6/site-packages (from markdown>=2.6.8->tensorboard~=2.4->tensorflow) (3.4.0)
Collecting pyasn1<0.5.0,>=0.4.6
  Downloading pyasn1-0.4.8-py2.py3-none-any.whl (77 kB)
     |████████████████████████████████| 77 kB 324 kB/s 
Requirement already satisfied: urllib3<1.27,>=1.21.1 in /usr/lib/python3/dist-packages (from requests<3,>=2.21.0->tensorboard~=2.4->tensorflow) (1.22)
Requirement already satisfied: idna<3,>=2.5 in /usr/lib/python3/dist-packages (from requests<3,>=2.21.0->tensorboard~=2.4->tensorflow) (2.6)
Requirement already satisfied: certifi>=2017.4.17 in /usr/lib/python3/dist-packages (from requests<3,>=2.21.0->tensorboard~=2.4->tensorflow) (2018.1.18)
Requirement already satisfied: chardet<5,>=3.0.2 in /usr/lib/python3/dist-packages (from requests<3,>=2.21.0->tensorboard~=2.4->tensorflow) (3.0.4)
Requirement already satisfied: oauthlib>=3.0.0 in /usr/local/lib/python3.6/dist-packages (from requests-oauthlib>=0.7.0->google-auth-oauthlib<0.5,>=0.4.1->tensorboard~=2.4->tensorflow) (3.1.0)
Collecting tensorboard-plugin-wit>=1.6.0
  Downloading tensorboard_plugin_wit-1.7.0-py3-none-any.whl (779 kB)
     |████████████████████████████████| 779 kB 587 kB/s 
Collecting tensorflow-estimator<2.5.0,>=2.4.0rc0
  Downloading tensorflow_estimator-2.4.0-py2.py3-none-any.whl (462 kB)
     |████████████████████████████████| 462 kB 603 kB/s 
Requirement already satisfied: zipp>=0.5 in /home/bios/.local/lib/python3.6/site-packages (from importlib-metadata->markdown>=2.6.8->tensorboard~=2.4->tensorflow) (3.4.0)
Installing collected packages: pyasn1, tensorboard-plugin-wit, grpcio, tensorflow-estimator, tensorboard, h5py, gast, flatbuffers, astunparse, tensorflow
  Attempting uninstall: grpcio
    Found existing installation: grpcio 1.34.1
    Uninstalling grpcio-1.34.1:
      Successfully uninstalled grpcio-1.34.1
  Attempting uninstall: tensorflow-estimator
    Found existing installation: tensorflow-estimator 1.14.0
    Uninstalling tensorflow-estimator-1.14.0:
      Successfully uninstalled tensorflow-estimator-1.14.0
  Attempting uninstall: tensorboard
    Found existing installation: tensorboard 1.14.0
    Uninstalling tensorboard-1.14.0:
      Successfully uninstalled tensorboard-1.14.0
  WARNING: The script tensorboard is installed in '/home/bios/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  Attempting uninstall: h5py
    Found existing installation: h5py 3.1.0
    Uninstalling h5py-3.1.0:
      Successfully uninstalled h5py-3.1.0
  Attempting uninstall: gast
    Found existing installation: gast 0.4.0
    Uninstalling gast-0.4.0:
      Successfully uninstalled gast-0.4.0
  Attempting uninstall: tensorflow
    Found existing installation: tensorflow 1.14.0
    Uninstalling tensorflow-1.14.0:
      Successfully uninstalled tensorflow-1.14.0
  WARNING: The scripts estimator_ckpt_converter, import_pb_to_tensorboard, saved_model_cli, tensorboard, tf_upgrade_v2, tflite_convert, toco and toco_from_protos are installed in '/home/bios/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
Successfully installed astunparse-1.6.3 flatbuffers-1.12 gast-0.3.3 grpcio-1.32.0 h5py-2.10.0 pyasn1-0.4.8 tensorboard-2.4.1 tensorboard-plugin-wit-1.7.0 tensorflow-2.4.0 tensorflow-estimator-2.4.0
```
