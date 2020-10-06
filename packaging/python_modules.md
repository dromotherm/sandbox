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
