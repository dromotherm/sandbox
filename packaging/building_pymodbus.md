# creating a deb file for pymodbus

installing pip 

```
sudo apt install python3-pip
```

cloning the debian folder

```
cd `~
mkdir test
cd test
git clone https://salsa.debian.org/python-team/packages/pymodbus.git pymodbus_3.0.0
curl https://github.com/riptideio/pymodbus/archive/refs/tags/v3.0.0.tar.gz > pymodbus_3.0.0.tar.gz
```


trying a build
```
cd pymodbus_3.0.0
debuild -us -uc
```
the output shows a failure :

```
 dpkg-buildpackage -us -uc -ui
dpkg-buildpackage: info: paquet source pymodbus
dpkg-buildpackage: info: version source 3.0.0-1
dpkg-buildpackage: info: distribution source unstable
dpkg-buildpackage: info: source changé par Martin <debacle@debian.org>
 dpkg-source --before-build .
dpkg-buildpackage: info: architecture hôte amd64
dpkg-source: info: using patch list from debian/patches/series
dpkg-source: info: mise en place de use-m2r-not-m2r2.patch
dpkg-source: info: mise en place de disable-failing-unittests.patch
dpkg-source: info: mise en place de privacy-breach-fixes.patch
dpkg-checkbuilddeps: erreur: Unmet build dependencies: dh-python python3-humanfriendly python3-m2r python3-mock python3-prompt-toolkit python3-pytest python3-pytest-asyncio python3-pytest-cov python3-recommonmark python3-redis python3-serial python3-serial-asyncio python3-setuptools python3-sphinx python3-sphinx-rtd-theme python3-sqlalchemy python3-typer
dpkg-buildpackage: avertissement: dépendances de construction et conflits non satisfaits ; échec.
dpkg-buildpackage: avertissement: (Utilisez l'option -d pour forcer.)
debuild: fatal error at line 1182:
dpkg-buildpackage -us -uc -ui failed
``` 

installing the missing dependancies :

```
sudo apt install dh-python python3-humanfriendly python3-m2r python3-mock python3-prompt-toolkit python3-pytest python3-pytest-asyncio python3-pytest-cov python3-recommonmark python3-redis python3-serial python3-serial-asyncio python3-setuptools python3-sphinx python3-sphinx-rtd-theme python3-sqlalchemy python3-typer
```
after that, the build is successfull...


