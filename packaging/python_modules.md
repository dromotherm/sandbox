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

what is possible is the following, although not very nice

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
