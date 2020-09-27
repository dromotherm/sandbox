# install dependancies for BIOS
```
pip3 install python-dateutil
sudo apt-get install python3-numpy
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
