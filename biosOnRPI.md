# install dependancies for BIOS

if your raspberry is in production and was not updated for a while :
```
sudo apt-get update -y
Get:1 http://raspbian.raspberrypi.org/raspbian buster InRelease [15.0 kB]
Get:2 http://archive.raspberrypi.org/debian buster InRelease [32.6 kB]
Get:3 http://raspbian.raspberrypi.org/raspbian buster/main armhf Packages [13.0 MB]
Get:4 http://archive.raspberrypi.org/debian buster/main armhf Packages [331 kB]
Get:5 http://raspbian.raspberrypi.org/raspbian buster/contrib armhf Packages [58.7 kB]                                        
Get:6 http://raspbian.raspberrypi.org/raspbian buster/non-free armhf Packages [104 kB]                                        
Fetched 13.5 MB in 18s (755 kB/s)                                                                                             
Reading package lists... Done
```
if pip3 is not present, you have to install it:
```
sudo apt-get install python3-pip
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following package was automatically installed and is no longer required:
  rpi.gpio-common
Use 'sudo apt autoremove' to remove it.
The following additional packages will be installed:
  dh-python libpython3-dev libpython3.7 libpython3.7-dev libpython3.7-minimal libpython3.7-stdlib python3-asn1crypto
  python3-cffi-backend python3-crypto python3-cryptography python3-dbus python3-dev python3-distutils python3-entrypoints
  python3-gi python3-keyring python3-keyrings.alt python3-lib2to3 python3-secretstorage python3-setuptools python3-wheel
  python3-xdg python3.7 python3.7-dev python3.7-minimal
Suggested packages:
  python-crypto-doc python-cryptography-doc python3-cryptography-vectors python-dbus-doc python3-dbus-dbg gnome-keyring
  libkf5wallet-bin gir1.2-gnomekeyring-1.0 python-secretstorage-doc python-setuptools-doc python3.7-venv python3.7-doc
  binfmt-support
The following NEW packages will be installed:
  dh-python libpython3-dev libpython3.7-dev python3-asn1crypto python3-cffi-backend python3-crypto python3-cryptography
  python3-dbus python3-dev python3-distutils python3-entrypoints python3-gi python3-keyring python3-keyrings.alt
  python3-lib2to3 python3-pip python3-secretstorage python3-setuptools python3-wheel python3-xdg python3.7-dev
The following packages will be upgraded:
  libpython3.7 libpython3.7-minimal libpython3.7-stdlib python3.7 python3.7-minimal
5 upgraded, 21 newly installed, 0 to remove and 125 not upgraded.
Need to get 53.0 MB/54.8 MB of archives.
After this operation, 80.5 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://mirrors.ircam.fr/pub/raspbian/raspbian buster/main armhf python3.7 armhf 3.7.3-2+deb10u2 [330 kB]
Get:2 http://mirrors.ircam.fr/pub/raspbian/raspbian buster/main armhf libpython3.7 armhf 3.7.3-2+deb10u2 [1,252 kB]
Get:3 http://mirrors.ircam.fr/pub/raspbian/raspbian buster/main armhf libpython3.7-stdlib armhf 3.7.3-2+deb10u2 [1,663 kB]
Get:4 http://mirrors.ircam.fr/pub/raspbian/raspbian buster/main armhf python3.7-minimal armhf 3.7.3-2+deb10u2 [1,463 kB]
Get:5 http://mirrors.ircam.fr/pub/raspbian/raspbian buster/main armhf libpython3.7-minimal armhf 3.7.3-2+deb10u2 [583 kB]
Get:6 http://mirrors.ircam.fr/pub/raspbian/raspbian buster/main armhf libpython3.7-dev armhf 3.7.3-2+deb10u2 [47.2 MB]
Get:7 http://mirrors.ircam.fr/pub/raspbian/raspbian buster/main armhf python3.7-dev armhf 3.7.3-2+deb10u2 [522 kB]            
Fetched 53.0 MB in 42s (1,252 kB/s)                                                                                           
Reading changelogs... Done
(Reading database ... 47138 files and directories currently installed.)
Preparing to unpack .../00-python3.7_3.7.3-2+deb10u2_armhf.deb ...
Unpacking python3.7 (3.7.3-2+deb10u2) over (3.7.3-2) ...
Preparing to unpack .../01-libpython3.7_3.7.3-2+deb10u2_armhf.deb ...
Unpacking libpython3.7:armhf (3.7.3-2+deb10u2) over (3.7.3-2) ...
Preparing to unpack .../02-libpython3.7-stdlib_3.7.3-2+deb10u2_armhf.deb ...
Unpacking libpython3.7-stdlib:armhf (3.7.3-2+deb10u2) over (3.7.3-2) ...
Preparing to unpack .../03-python3.7-minimal_3.7.3-2+deb10u2_armhf.deb ...
Unpacking python3.7-minimal (3.7.3-2+deb10u2) over (3.7.3-2) ...
Preparing to unpack .../04-libpython3.7-minimal_3.7.3-2+deb10u2_armhf.deb ...
Unpacking libpython3.7-minimal:armhf (3.7.3-2+deb10u2) over (3.7.3-2) ...
Selecting previously unselected package python3-lib2to3.
Preparing to unpack .../05-python3-lib2to3_3.7.3-1_all.deb ...
Unpacking python3-lib2to3 (3.7.3-1) ...
Selecting previously unselected package python3-distutils.
Preparing to unpack .../06-python3-distutils_3.7.3-1_all.deb ...
Unpacking python3-distutils (3.7.3-1) ...
Selecting previously unselected package dh-python.
Preparing to unpack .../07-dh-python_3.20190308_all.deb ...
Unpacking dh-python (3.20190308) ...
Selecting previously unselected package libpython3.7-dev:armhf.
Preparing to unpack .../08-libpython3.7-dev_3.7.3-2+deb10u2_armhf.deb ...
Unpacking libpython3.7-dev:armhf (3.7.3-2+deb10u2) ...
Selecting previously unselected package libpython3-dev:armhf.
Preparing to unpack .../09-libpython3-dev_3.7.3-1_armhf.deb ...
Unpacking libpython3-dev:armhf (3.7.3-1) ...
Selecting previously unselected package python3-asn1crypto.
Preparing to unpack .../10-python3-asn1crypto_0.24.0-1_all.deb ...
Unpacking python3-asn1crypto (0.24.0-1) ...
Selecting previously unselected package python3-cffi-backend.
Preparing to unpack .../11-python3-cffi-backend_1.12.2-1_armhf.deb ...
Unpacking python3-cffi-backend (1.12.2-1) ...
Selecting previously unselected package python3-crypto.
Preparing to unpack .../12-python3-crypto_2.6.1-9+b1_armhf.deb ...
Unpacking python3-crypto (2.6.1-9+b1) ...
Selecting previously unselected package python3-cryptography.
Preparing to unpack .../13-python3-cryptography_2.6.1-3+deb10u2_armhf.deb ...
Unpacking python3-cryptography (2.6.1-3+deb10u2) ...
Selecting previously unselected package python3-dbus.
Preparing to unpack .../14-python3-dbus_1.2.8-3_armhf.deb ...
Unpacking python3-dbus (1.2.8-3) ...
Selecting previously unselected package python3.7-dev.
Preparing to unpack .../15-python3.7-dev_3.7.3-2+deb10u2_armhf.deb ...
Unpacking python3.7-dev (3.7.3-2+deb10u2) ...
Selecting previously unselected package python3-dev.
Preparing to unpack .../16-python3-dev_3.7.3-1_armhf.deb ...
Unpacking python3-dev (3.7.3-1) ...
Selecting previously unselected package python3-entrypoints.
Preparing to unpack .../17-python3-entrypoints_0.3-1_all.deb ...
Unpacking python3-entrypoints (0.3-1) ...
Selecting previously unselected package python3-gi.
Preparing to unpack .../18-python3-gi_3.30.4-1_armhf.deb ...
Unpacking python3-gi (3.30.4-1) ...
Selecting previously unselected package python3-secretstorage.
Preparing to unpack .../19-python3-secretstorage_2.3.1-2_all.deb ...
Unpacking python3-secretstorage (2.3.1-2) ...
Selecting previously unselected package python3-keyring.
Preparing to unpack .../20-python3-keyring_17.1.1-1_all.deb ...
Unpacking python3-keyring (17.1.1-1) ...
Selecting previously unselected package python3-keyrings.alt.
Preparing to unpack .../21-python3-keyrings.alt_3.1.1-1_all.deb ...
Unpacking python3-keyrings.alt (3.1.1-1) ...
Selecting previously unselected package python3-pip.
Preparing to unpack .../22-python3-pip_18.1-5+rpt1_all.deb ...
Unpacking python3-pip (18.1-5+rpt1) ...
Selecting previously unselected package python3-setuptools.
Preparing to unpack .../23-python3-setuptools_40.8.0-1_all.deb ...
Unpacking python3-setuptools (40.8.0-1) ...
Selecting previously unselected package python3-wheel.
Preparing to unpack .../24-python3-wheel_0.32.3-2_all.deb ...
Unpacking python3-wheel (0.32.3-2) ...
Selecting previously unselected package python3-xdg.
Preparing to unpack .../25-python3-xdg_0.25-5_all.deb ...
Unpacking python3-xdg (0.25-5) ...
Setting up python3-entrypoints (0.3-1) ...
Setting up python3-dbus (1.2.8-3) ...
Setting up python3-xdg (0.25-5) ...
Setting up libpython3.7-minimal:armhf (3.7.3-2+deb10u2) ...
Setting up python3-wheel (0.32.3-2) ...
Setting up python3-gi (3.30.4-1) ...
Setting up python3.7-minimal (3.7.3-2+deb10u2) ...
Setting up python3-crypto (2.6.1-9+b1) ...
Setting up python3-lib2to3 (3.7.3-1) ...
Setting up python3-asn1crypto (0.24.0-1) ...
Setting up python3-cffi-backend (1.12.2-1) ...
Setting up python3-distutils (3.7.3-1) ...
Setting up dh-python (3.20190308) ...
Setting up libpython3.7-stdlib:armhf (3.7.3-2+deb10u2) ...
Setting up python3-setuptools (40.8.0-1) ...
Setting up libpython3.7:armhf (3.7.3-2+deb10u2) ...
Setting up libpython3.7-dev:armhf (3.7.3-2+deb10u2) ...
Setting up python3-cryptography (2.6.1-3+deb10u2) ...
Setting up python3-pip (18.1-5+rpt1) ...
Setting up python3-keyrings.alt (3.1.1-1) ...
Setting up python3.7 (3.7.3-2+deb10u2) ...
Setting up libpython3-dev:armhf (3.7.3-1) ...
Setting up python3.7-dev (3.7.3-2+deb10u2) ...
Setting up python3-secretstorage (2.3.1-2) ...
Setting up python3-dev (3.7.3-1) ...
Setting up python3-keyring (17.1.1-1) ...
Processing triggers for libc-bin (2.28-10+rpi1) ...
Processing triggers for man-db (2.8.5-2) ...
Processing triggers for mime-support (3.62) ...
```
You can check what basic libraries have been installed :
```
pip3 list
Package       Version  
------------- ---------
asn1crypto    0.24.0   
certifi       2018.8.24
chardet       3.0.4    
cryptography  2.6.1    
entrypoints   0.3      
idna          2.6      
keyring       17.1.1   
keyrings.alt  3.1.1    
pip           18.1     
pycrypto      2.6.1    
PyGObject     3.30.4   
python-apt    1.8.4    
pyxdg         0.25     
requests      2.21.0   
SecretStorage 2.3.1    
setuptools    40.8.0   
six           1.12.0   
ssh-import-id 5.7      
ufw           0.36     
urllib3       1.24.1   
wheel         0.32.3 
```

To install numpy :
```
sudo apt-get install python3-numpy
```
~~pip3 install python-dateutil~~

checkout from themis to master (the "redis feeds" implementation, to store meteo forecasts, has not yet been committed to the themis branch)
```
cd /var/www/emoncms
git checkout master
git pull
```

# install numpy on raspberry

## tried without success
```
export TMPDIR=/var/opt/emoncms
cd /var/opt/emoncms
sudo mkdir http
sudo chown pi http
pip3 install numpy --cache-dir=/var/opt/emoncms/http --build /var/opt/emoncms/http
```
here is the return
```
Looking in indexes: https://pypi.org/simple, https://www.piwheels.org/simple
Collecting numpy
  Using cached https://www.piwheels.org/simple/numpy/numpy-1.19.2-cp37-cp37m-linux_armv7l.whl
Installing collected packages: numpy
  The scripts f2py, f2py3 and f2py3.7 are installed in '/home/pi/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
Successfully installed numpy-1.19.2
```

when running a simple numpy code :
```
python3 test.py
Traceback (most recent call last):
  File "/home/pi/.local/lib/python3.7/site-packages/numpy/core/__init__.py", line 22, in <module>
    from . import multiarray
  File "/home/pi/.local/lib/python3.7/site-packages/numpy/core/multiarray.py", line 12, in <module>
    from . import overrides
  File "/home/pi/.local/lib/python3.7/site-packages/numpy/core/overrides.py", line 7, in <module>
    from numpy.core._multiarray_umath import (
ImportError: libf77blas.so.3: cannot open shared object file: No such file or directory

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "test.py", line 1, in <module>
    import numpy as np
  File "/home/pi/.local/lib/python3.7/site-packages/numpy/__init__.py", line 140, in <module>
    from . import core
  File "/home/pi/.local/lib/python3.7/site-packages/numpy/core/__init__.py", line 48, in <module>
    raise ImportError(msg)
ImportError: 

IMPORTANT: PLEASE READ THIS FOR ADVICE ON HOW TO SOLVE THIS ISSUE!

Importing the numpy C-extensions failed. This error can happen for
many reasons, often due to issues with your setup or how NumPy was
installed.

We have compiled some common reasons and troubleshooting tips at:

    https://numpy.org/devdocs/user/troubleshooting-importerror.html

Please note and check the following:

  * The Python version is: Python3.7 from "/usr/bin/python3"
  * The NumPy version is: "1.19.2"

and make sure that they are the versions you expect.
Please carefully study the documentation linked above for further help.

Original error was: libf77blas.so.3: cannot open shared object file: No such file or directory
```

maybe could have tested :
```
sudo apt install libatlas3-base
pip3 install numpy
```
so all removed with : `pip3 uninstall numpy`

But got errors :
```
Uninstalling numpy-1.19.2:
  Would remove:
    /home/pi/.local/bin/f2py
    /home/pi/.local/bin/f2py3
    /home/pi/.local/bin/f2py3.7
    /home/pi/.local/lib/python3.7/site-packages/numpy-1.19.2.dist-info/*
    /home/pi/.local/lib/python3.7/site-packages/numpy/*
Proceed (y/n)? y
Exception:
Traceback (most recent call last):
  File "/usr/lib/python3.7/shutil.py", line 563, in move
    os.rename(src, real_dst)
OSError: [Errno 18] Invalid cross-device link: '/home/pi/.local/lib/python3.7/site-packages/numpy/random/_common.cpython-37m-arm-linux-gnueabihf.so' -> '/tmp/pip-uninstall-dn_he5xa/home/pi/.local/lib/python3.7/site-packages/numpy/random/_common.cpython-37m-arm-linux-gnueabihf.so'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/lib/python3.7/shutil.py", line 122, in copyfile
    copyfileobj(fsrc, fdst)
  File "/usr/lib/python3.7/shutil.py", line 82, in copyfileobj
    fdst.write(buf)
OSError: [Errno 28] No space left on device

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/lib/python3/dist-packages/pip/_internal/cli/base_command.py", line 143, in main
    status = self.run(options, args)
  File "/usr/lib/python3/dist-packages/pip/_internal/commands/uninstall.py", line 75, in run
    auto_confirm=options.yes, verbose=self.verbosity > 0,
  File "/usr/lib/python3/dist-packages/pip/_internal/req/req_install.py", line 683, in uninstall
    uninstalled_pathset.remove(auto_confirm, verbose)
  File "/usr/lib/python3/dist-packages/pip/_internal/req/req_uninstall.py", line 224, in remove
    renames(path, new_path)
  File "/usr/lib/python3/dist-packages/pip/_internal/utils/misc.py", line 280, in renames
    shutil.move(old, new)
  File "/usr/lib/python3.7/shutil.py", line 577, in move
    copy_function(src, real_dst)
  File "/usr/lib/python3.7/shutil.py", line 263, in copy2
    copyfile(src, dst, follow_symlinks=follow_symlinks)
  File "/usr/lib/python3.7/shutil.py", line 122, in copyfile
    copyfileobj(fsrc, fdst)
OSError: [Errno 28] No space left on device
```

## the good option is to do it with apt

```
sudo apt-get install python3-numpy
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  libblas3 libgfortran5 liblapack3
Suggested packages:
  gfortran python-numpy-doc python3-pytest python3-numpy-dbg
The following NEW packages will be installed:
  libblas3 libgfortran5 liblapack3 python3-numpy
0 upgraded, 4 newly installed, 0 to remove and 0 not upgraded.
Need to get 3,676 kB of archives.
After this operation, 17.4 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://ftp.igh.cnrs.fr/pub/os/linux/raspbian/raspbian buster/main armhf libgfortran5 armhf 8.3.0-6+rpi1 [206 kB]
Get:2 http://mirrors.ircam.fr/pub/raspbian/raspbian buster/main armhf libblas3 armhf 3.8.0-2 [103 kB]
Get:3 http://mirrors.ircam.fr/pub/raspbian/raspbian buster/main armhf liblapack3 armhf 3.8.0-2 [1,493 kB]
Get:4 http://mirrors.ircam.fr/pub/raspbian/raspbian buster/main armhf python3-numpy armhf 1:1.16.2-1 [1,873 kB]
Fetched 3,676 kB in 3s (1,253 kB/s)        
Selecting previously unselected package libgfortran5:armhf.
(Reading database ... 54490 files and directories currently installed.)
Preparing to unpack .../libgfortran5_8.3.0-6+rpi1_armhf.deb ...
Unpacking libgfortran5:armhf (8.3.0-6+rpi1) ...
Selecting previously unselected package libblas3:armhf.
Preparing to unpack .../libblas3_3.8.0-2_armhf.deb ...
Unpacking libblas3:armhf (3.8.0-2) ...
Selecting previously unselected package liblapack3:armhf.
Preparing to unpack .../liblapack3_3.8.0-2_armhf.deb ...
Unpacking liblapack3:armhf (3.8.0-2) ...
Selecting previously unselected package python3-numpy.
Preparing to unpack .../python3-numpy_1%3a1.16.2-1_armhf.deb ...
Unpacking python3-numpy (1:1.16.2-1) ...
Setting up libgfortran5:armhf (8.3.0-6+rpi1) ...
Setting up libblas3:armhf (3.8.0-2) ...
update-alternatives: using /usr/lib/arm-linux-gnueabihf/blas/libblas.so.3 to provide /usr/lib/arm-linux-gnueabihf/libblas.so.3 (libblas.so.3-arm-linux-gnueabihf) in auto mode
Setting up liblapack3:armhf (3.8.0-2) ...
update-alternatives: using /usr/lib/arm-linux-gnueabihf/lapack/liblapack.so.3 to provide /usr/lib/arm-linux-gnueabihf/liblapack.so.3 (liblapack.so.3-arm-linux-gnueabihf) in auto mode
Setting up python3-numpy (1:1.16.2-1) ...
Processing triggers for libc-bin (2.28-10+rpi1) ...
```
when listing the pip packages :
```
pip3 list
Package          Version  
---------------- ---------
asn1crypto       0.24.0   
attrs            18.2.0   
Automat          0.6.0    
certifi          2018.8.24
chardet          3.0.4    
Click            7.0      
colorama         0.3.7    
colorzero        1.1      
configobj        5.0.6    
constantly       15.1.0   
cryptography     2.6.1    
entrypoints      0.3      
gpiozero         1.5.1    
hyperlink        17.3.1   
idna             2.6      
incremental      16.10.1  
keyring          17.1.1   
keyrings.alt     3.1.1    
numpy            1.16.2   
paho-mqtt        1.5.0    
pip              18.1     
pyasn1           0.4.2    
pyasn1-modules   0.2.1    
pycrypto         2.6.1    
PyGObject        3.30.4   
pymodbus         2.1.0    
pyOpenSSL        19.0.0   
pyserial         3.4      
pyserial-asyncio 0.4      
python-apt       1.8.4.1  
pyxdg            0.25     
redis            3.5.3    
requests         2.21.0   
RPi.GPIO         0.7.0    
SecretStorage    2.3.1    
service-identity 16.0.0   
setuptools       40.8.0   
six              1.12.0   
spidev           3.4      
ssh-import-id    5.7      
Twisted          18.9.0   
ufw              0.36     
urllib3          1.24.1   
wheel            0.32.3   
xmltodict        0.12.0   
zope.interface   4.3.2    
```
