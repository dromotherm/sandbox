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
```
You can check what basic libraries have been installed (you can see requests and urllib3) :
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
So you rely on a stable version....
```
sudo apt-get install python3-numpy
```
