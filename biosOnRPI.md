# install numpy on raspberry
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
