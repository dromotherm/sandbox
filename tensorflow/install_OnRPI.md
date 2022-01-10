# extract of a correct install

raspiOS Buster python3.7

prerequisite : `sudo pip3 install pip --upgrade`

for the TMPDIR tip : https://github.com/pypa/pip/issues/5816

```
TMPDIR=/var/opt/emoncms/test pip3 install --upgrade --no-cache-dir --upgrade tensorflow-2.4.0rc2-cp37-none-linux_armv7l.whl 
Defaulting to user installation because normal site-packages is not writeable
Looking in indexes: https://pypi.org/simple, https://www.piwheels.org/simple
Processing ./tensorflow-2.4.0rc2-cp37-none-linux_armv7l.whl
Collecting tensorboard~=2.4
  Downloading tensorboard-2.7.0-py3-none-any.whl (5.8 MB)
     |████████████████████████████████| 5.8 MB 956 kB/s            
Collecting opt-einsum~=3.3.0
  Downloading https://www.piwheels.org/simple/opt-einsum/opt_einsum-3.3.0-py3-none-any.whl (65 kB)
     |████████████████████████████████| 65 kB 998 kB/s            
Collecting absl-py~=0.10
  Downloading https://www.piwheels.org/simple/absl-py/absl_py-0.15.0-py3-none-any.whl (129 kB)
     |████████████████████████████████| 129 kB 1.4 MB/s            
Collecting astunparse~=1.6.3
  Downloading https://www.piwheels.org/simple/astunparse/astunparse-1.6.3-py2.py3-none-any.whl (12 kB)
Collecting flatbuffers~=1.12.0
  Downloading https://www.piwheels.org/simple/flatbuffers/flatbuffers-1.12-py2.py3-none-any.whl (15 kB)
Collecting termcolor~=1.1.0
  Downloading https://www.piwheels.org/simple/termcolor/termcolor-1.1.0-py3-none-any.whl (4.8 kB)
Collecting protobuf~=3.13.0
  Downloading https://www.piwheels.org/simple/protobuf/protobuf-3.13.0-py2.py3-none-any.whl (438 kB)
     |████████████████████████████████| 438 kB 989 kB/s            
Collecting keras-preprocessing~=1.1.2
  Downloading https://www.piwheels.org/simple/keras-preprocessing/Keras_Preprocessing-1.1.2-py2.py3-none-any.whl (42 kB)
     |████████████████████████████████| 42 kB 1.3 MB/s            
Collecting six~=1.15.0
  Downloading https://www.piwheels.org/simple/six/six-1.15.0-py2.py3-none-any.whl (10 kB)
Collecting wheel~=0.35
  Downloading https://www.piwheels.org/simple/wheel/wheel-0.37.1-py2.py3-none-any.whl (35 kB)
Collecting h5py~=2.10.0
  Downloading https://www.piwheels.org/simple/h5py/h5py-2.10.0-cp37-cp37m-linux_armv7l.whl (4.7 MB)
     |████████████████████████████████| 4.7 MB 2.0 MB/s            
Collecting tensorflow-estimator<2.5.0,>=2.4.0rc0
  Downloading tensorflow_estimator-2.4.0-py2.py3-none-any.whl (462 kB)
     |████████████████████████████████| 462 kB 4.4 MB/s            
Collecting wrapt~=1.12.1
  Downloading https://www.piwheels.org/simple/wrapt/wrapt-1.12.1-cp37-cp37m-linux_armv7l.whl (68 kB)
     |████████████████████████████████| 68 kB 987 kB/s            
Collecting gast==0.3.3
  Downloading https://www.piwheels.org/simple/gast/gast-0.3.3-py2.py3-none-any.whl (9.7 kB)
Collecting numpy~=1.19.2
  Downloading https://www.piwheels.org/simple/numpy/numpy-1.19.5-cp37-cp37m-linux_armv7l.whl (10.5 MB)
     |████████████████████████████████| 10.5 MB 4.0 MB/s            
Collecting google-pasta~=0.2
  Downloading https://www.piwheels.org/simple/google-pasta/google_pasta-0.2.0-py3-none-any.whl (57 kB)
     |████████████████████████████████| 57 kB 841 kB/s            
Collecting grpcio~=1.32.0
  Downloading https://www.piwheels.org/simple/grpcio/grpcio-1.32.0-cp37-cp37m-linux_armv7l.whl (32.8 MB)
     |████████████████████████████████| 32.8 MB 3.9 MB/s            
Collecting typing-extensions~=3.7.4
  Downloading https://www.piwheels.org/simple/typing-extensions/typing_extensions-3.7.4.3-py3-none-any.whl (22 kB)
Requirement already satisfied: setuptools in /home/pi/.local/lib/python3.7/site-packages (from protobuf~=3.13.0->tensorflow==2.4.0rc2) (60.5.0)
Collecting werkzeug>=0.11.15
  Downloading https://www.piwheels.org/simple/werkzeug/Werkzeug-2.0.2-py3-none-any.whl (288 kB)
     |████████████████████████████████| 288 kB 897 kB/s            
Collecting google-auth<3,>=1.6.3
  Downloading https://www.piwheels.org/simple/google-auth/google_auth-2.3.3-py2.py3-none-any.whl (155 kB)
     |████████████████████████████████| 155 kB 909 kB/s            
Requirement already satisfied: requests<3,>=2.21.0 in /usr/lib/python3/dist-packages (from tensorboard~=2.4->tensorflow==2.4.0rc2) (2.21.0)
Collecting tensorboard-data-server<0.7.0,>=0.6.0
  Downloading tensorboard_data_server-0.6.1-py3-none-any.whl (2.4 kB)
Collecting markdown>=2.6.8
  Downloading https://www.piwheels.org/simple/markdown/Markdown-3.3.6-py3-none-any.whl (97 kB)
     |████████████████████████████████| 97 kB 1.2 MB/s            
Collecting tensorboard-plugin-wit>=1.6.0
  Downloading tensorboard_plugin_wit-1.8.1-py3-none-any.whl (781 kB)
     |████████████████████████████████| 781 kB 6.5 MB/s            
Collecting google-auth-oauthlib<0.5,>=0.4.1
  Downloading https://www.piwheels.org/simple/google-auth-oauthlib/google_auth_oauthlib-0.4.6-py2.py3-none-any.whl (18 kB)
Collecting cachetools<5.0,>=2.0.0
  Downloading https://www.piwheels.org/simple/cachetools/cachetools-4.2.4-py3-none-any.whl (10 kB)
Requirement already satisfied: pyasn1-modules>=0.2.1 in /usr/lib/python3/dist-packages (from google-auth<3,>=1.6.3->tensorboard~=2.4->tensorflow==2.4.0rc2) (0.2.1)
Collecting rsa<5,>=3.1.4
  Downloading https://www.piwheels.org/simple/rsa/rsa-4.8-py3-none-any.whl (39 kB)
Collecting requests-oauthlib>=0.7.0
  Downloading https://www.piwheels.org/simple/requests-oauthlib/requests_oauthlib-1.3.0-py2.py3-none-any.whl (23 kB)
Requirement already satisfied: importlib-metadata>=4.4 in /home/pi/.local/lib/python3.7/site-packages (from markdown>=2.6.8->tensorboard~=2.4->tensorflow==2.4.0rc2) (4.10.0)
Requirement already satisfied: zipp>=0.5 in /home/pi/.local/lib/python3.7/site-packages (from importlib-metadata>=4.4->markdown>=2.6.8->tensorboard~=2.4->tensorflow==2.4.0rc2) (3.7.0)
Collecting oauthlib>=3.0.0
  Downloading https://www.piwheels.org/simple/oauthlib/oauthlib-3.1.1-py2.py3-none-any.whl (146 kB)
     |████████████████████████████████| 146 kB 674 kB/s            
Requirement already satisfied: pyasn1>=0.1.3 in /usr/lib/python3/dist-packages (from rsa<5,>=3.1.4->google-auth<3,>=1.6.3->tensorboard~=2.4->tensorflow==2.4.0rc2) (0.4.2)
Installing collected packages: typing-extensions, six, rsa, oauthlib, cachetools, requests-oauthlib, google-auth, wheel, werkzeug, tensorboard-plugin-wit, tensorboard-data-server, protobuf, numpy, markdown, grpcio, google-auth-oauthlib, absl-py, wrapt, termcolor, tensorflow-estimator, tensorboard, opt-einsum, keras-preprocessing, h5py, google-pasta, gast, flatbuffers, astunparse, tensorflow
  Attempting uninstall: typing-extensions
    Found existing installation: typing-extensions 4.0.1
    Uninstalling typing-extensions-4.0.1:
      Successfully uninstalled typing-extensions-4.0.1
  WARNING: The scripts pyrsa-decrypt, pyrsa-encrypt, pyrsa-keygen, pyrsa-priv2pub, pyrsa-sign and pyrsa-verify are installed in '/home/pi/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The script wheel is installed in '/home/pi/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The scripts f2py, f2py3 and f2py3.7 are installed in '/home/pi/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The script markdown_py is installed in '/home/pi/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The script google-oauthlib-tool is installed in '/home/pi/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  Attempting uninstall: wrapt
    Found existing installation: wrapt 1.13.3
    Uninstalling wrapt-1.13.3:
      Successfully uninstalled wrapt-1.13.3
  WARNING: The script tensorboard is installed in '/home/pi/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The scripts estimator_ckpt_converter, import_pb_to_tensorboard, saved_model_cli, tensorboard, tf_upgrade_v2, tflite_convert, toco and toco_from_protos are installed in '/home/pi/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
Successfully installed absl-py-0.15.0 astunparse-1.6.3 cachetools-4.2.4 flatbuffers-1.12 gast-0.3.3 google-auth-2.3.3 google-auth-oauthlib-0.4.6 google-pasta-0.2.0 grpcio-1.32.0 h5py-2.10.0 keras-preprocessing-1.1.2 markdown-3.3.6 numpy-1.19.5 oauthlib-3.1.1 opt-einsum-3.3.0 protobuf-3.13.0 requests-oauthlib-1.3.0 rsa-4.8 six-1.15.0 tensorboard-2.7.0 tensorboard-data-server-0.6.1 tensorboard-plugin-wit-1.8.1 tensorflow-2.4.0rc2 tensorflow-estimator-2.4.0 termcolor-1.1.0 typing-extensions-3.7.4.3 werkzeug-2.0.2 wheel-0.37.1 wrapt-1.12.1
```
# suites
installation de libatlas
```
sudo apt-get install libatlas-base-dev
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following packages were automatically installed and are no longer required:
  python-colorzero python3-crypto python3-dbus python3-entrypoints
  python3-keyring python3-keyrings.alt python3-secretstorage python3-xdg
Use 'sudo apt autoremove' to remove them.
The following additional packages will be installed:
  libatlas3-base
Suggested packages:
  libatlas-doc liblapack-doc
The following NEW packages will be installed:
  libatlas-base-dev libatlas3-base
0 upgraded, 2 newly installed, 0 to remove and 0 not upgraded.
Need to get 5,365 kB of archives.
After this operation, 32.1 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://mirrors.ircam.fr/pub/raspbian/raspbian buster/main armhf libatlas3-base armhf 3.10.3-8+rpi1 [2,399 kB]
Get:2 https://ftp.igh.cnrs.fr/pub/os/linux/raspbian/raspbian buster/main armhf libatlas-base-dev armhf 3.10.3-8+rpi1 [2,966 kB]
Fetched 5,365 kB in 5s (1,178 kB/s)                                          
Selecting previously unselected package libatlas3-base:armhf.
(Reading database ... 49403 files and directories currently installed.)
Preparing to unpack .../libatlas3-base_3.10.3-8+rpi1_armhf.deb ...
Unpacking libatlas3-base:armhf (3.10.3-8+rpi1) ...
Selecting previously unselected package libatlas-base-dev:armhf.
Preparing to unpack .../libatlas-base-dev_3.10.3-8+rpi1_armhf.deb ...
Unpacking libatlas-base-dev:armhf (3.10.3-8+rpi1) ...
Setting up libatlas3-base:armhf (3.10.3-8+rpi1) ...
update-alternatives: using /usr/lib/arm-linux-gnueabihf/atlas/libblas.so.3 to provide /usr/lib/arm-linux-gnueabihf/libblas.so.3 (libblas.so.3-arm-linux-gnueabihf) in auto mode
update-alternatives: using /usr/lib/arm-linux-gnueabihf/atlas/liblapack.so.3 to provide /usr/lib/arm-linux-gnueabihf/liblapack.so.3 (liblapack.so.3-arm-linux-gnueabihf) in auto mode
Setting up libatlas-base-dev:armhf (3.10.3-8+rpi1) ...
update-alternatives: using /usr/lib/arm-linux-gnueabihf/atlas/libblas.so to provide /usr/lib/arm-linux-gnueabihf/libblas.so (libblas.so-arm-linux-gnueabihf) in auto mode
update-alternatives: using /usr/lib/arm-linux-gnueabihf/atlas/liblapack.so to provide /usr/lib/arm-linux-gnueabihf/liblapack.so (liblapack.so-arm-linux-gnueabihf) in auto mode
Processing triggers for libc-bin (2.28-10+rpt2+rpi1) ...
```
toutefois, tensorflow ne fonctionnait pas encore :
```
python3 replayNN.py 
RuntimeError: module compiled against API version 0xe but this version of numpy is 0xd
RuntimeError: module compiled against API version 0xe but this version of numpy is 0xd
ImportError: numpy.core._multiarray_umath failed to import
ImportError: numpy.core.umath failed to import
2022-01-10 20:37:09.859081: F tensorflow/python/lib/core/bfloat16.cc:714] Check failed: PyBfloat16_Type.tp_base != nullptr 
Aborted
```
on upgrade numpy
```
pip3 install --upgrade numpy
Defaulting to user installation because normal site-packages is not writeable
Looking in indexes: https://pypi.org/simple, https://www.piwheels.org/simple
Requirement already satisfied: numpy in /home/pi/.local/lib/python3.7/site-packages (1.19.2)
Collecting numpy
  Using cached https://www.piwheels.org/simple/numpy/numpy-1.21.5-cp37-cp37m-linux_armv7l.whl (12.3 MB)
Installing collected packages: numpy
  Attempting uninstall: numpy
    Found existing installation: numpy 1.19.2
    Uninstalling numpy-1.19.2:
      Successfully uninstalled numpy-1.19.2
  WARNING: The scripts f2py, f2py3 and f2py3.7 are installed in '/home/pi/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
ERROR: pip's dependency resolver does not currently take into account all the packages that are installed. This behaviour is the source of the following dependency conflicts.
tensorflow 2.4.0rc2 requires numpy~=1.19.2, but you have numpy 1.21.5 which is incompatible.
Successfully installed numpy-1.21.5
```
il y a une erreur mais tensorflow fonctionne
```
python3 replayNN.py 
température extérieure ? [8.56]: 9.17
température intérieure ? [14.8]: 17.8
température de consigne ? [0]: 0
nombre d'heures au changement d'occupation ? [43.0]: 14.5
pas de temps en heures ? [1.0]: 0.5
nom de l'agent ? (2021_09_23_07_42_32_hys20_retrained_k0dot9_hys20, 4parsChh) [2021_09_23_07_42_32_hys20_retrained_k0dot9_hys20]: 
sortie du réseau au moment présent [[-5.0913396 -5.1482563]] soit chauffage 0
[0. 0. 1. 1. 1. 1. 1. 1. 1. 1. 1. 1. 1. 1. 1. 1. 1. 1. 1. 1. 1. 1. 1. 1.
 1. 1. 1. 1. 1.]
chauffage dans 1.0 heures au maximum
```
