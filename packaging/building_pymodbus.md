# creating a deb file for pymodbus

installing pip to check after with `pip show pymodbus | grep Location`

```
sudo apt install python3-pip
```

cloning the debian folder from the python team and fetching the upstream tar.gz

```
cd `~
mkdir test
cd test
git clone https://salsa.debian.org/python-team/packages/pymodbus.git pymodbus_3.0.0
curl -L https://github.com/riptideio/pymodbus/archive/refs/tags/v3.0.0.tar.gz > pymodbus_3.0.0.orig.tar.gz
sudo apt install dh-python python3-humanfriendly python3-m2r python3-mock python3-prompt-toolkit python3-pytest python3-pytest-asyncio python3-pytest-cov python3-recommonmark python3-redis python3-serial python3-serial-asyncio python3-setuptools python3-sphinx python3-sphinx-rtd-theme python3-sqlalchemy python3-typer
cd pymodbus_3.0.0
debuild -us -uc
```


# trying a build without dependancies installed should fail

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


# to install the created deb file with apt

```
cd ..
sudo apt install ./python3-pymodbus_3.0.0-1_all.deb
```
output :
```
Lecture des listes de paquets... Fait
Construction de l'arbre des dépendances... Fait
Lecture des informations d'état... Fait      
Note : sélection de « python3-pymodbus » au lieu de « ./python3-pymodbus_3.0.0-1_all.deb »
Les paquets suivants ont été installés automatiquement et ne sont plus nécessaires :
  libflashrom1 libftdi1-2
Veuillez utiliser « sudo apt autoremove » pour les supprimer.
Les NOUVEAUX paquets suivants seront installés :
  python3-pymodbus
0 mis à jour, 1 nouvellement installés, 0 à enlever et 2 non mis à jour.
Il est nécessaire de prendre 0 o/90,6 ko dans les archives.
Après cette opération, 622 ko d'espace disque supplémentaires seront utilisés.
Réception de :1 /home/alexandrecuer/test/test2/python3-pymodbus_3.0.0-1_all.deb python3-pymodbus all 3.0.0-1 [90,6 kB]
Sélection du paquet python3-pymodbus précédemment désélectionné.
(Lecture de la base de données... 236179 fichiers et répertoires déjà installés.
)
Préparation du dépaquetage de .../python3-pymodbus_3.0.0-1_all.deb ...
Dépaquetage de python3-pymodbus (3.0.0-1) ...
Paramétrage de python3-pymodbus (3.0.0-1) ...
N: Le téléchargement est effectué en dehors du bac à sable en tant que « root » car le fichier « /home/alexandrecuer/test/test2/python3-pymodbus_3.0.0-1_all.deb » n'est pas accessible par l'utilisateur « _apt ». - pkgAcquire::Run (13: Permission non accordée)
```

