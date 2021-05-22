On suit le tutorial suivant :

https://packaging.python.org/tutorials/packaging-projects/

On s'assure de disposer de la dernière version de build `python3 -m pip install --upgrade build`
```
Defaulting to user installation because normal site-packages is not writeable
Collecting build
  Downloading build-0.3.1.post1-py2.py3-none-any.whl (13 kB)
Collecting pep517>=0.9
  Downloading pep517-0.10.0-py2.py3-none-any.whl (19 kB)
Requirement already satisfied, skipping upgrade: importlib-metadata; python_version < "3.8" in /home/alexandrecuer/.local/lib/python3.6/site-packages (from build) (1.5.0)
Requirement already satisfied, skipping upgrade: toml in /home/alexandrecuer/.local/lib/python3.6/site-packages (from build) (0.10.0)
Requirement already satisfied, skipping upgrade: packaging in /home/alexandrecuer/.local/lib/python3.6/site-packages (from build) (20.3)
Requirement already satisfied, skipping upgrade: zipp; python_version < "3.8" in /home/alexandrecuer/.local/lib/python3.6/site-packages (from pep517>=0.9->build) (3.0.0)
Requirement already satisfied, skipping upgrade: pyparsing>=2.0.2 in /usr/lib/python3/dist-packages (from packaging->build) (2.2.0)
Requirement already satisfied, skipping upgrade: six in /home/alexandrecuer/.local/lib/python3.6/site-packages (from packaging->build) (1.15.0)
Installing collected packages: pep517, build
Successfully installed build-0.3.1.post1 pep517-0.10.0
WARNING: You are using pip version 20.0.2; however, version 21.1.1 is available.
You should consider upgrading via the '/usr/bin/python3 -m pip install --upgrade pip' command.
```

Il se peut que la commande `python3 -m build` n'aboutisse pas :
```
The virtual environment was not created successfully because ensurepip is not
available.  On Debian/Ubuntu systems, you need to install the python3-venv
package using the following command.

    apt-get install python3-venv

You may need to use sudo with that command.  After installing the python3-venv
package, recreate your virtual environment.

Failing command: ['/tmp/build-env-t7xr3bzm/bin/python3', '-Im', 'ensurepip', '--upgrade', '--default-pip']
```
Il faut alors installer python3-venv `sudo apt-get install python3-venv`
```
Lecture des listes de paquets... Fait
Construction de l'arbre des dépendances       
Lecture des informations d'état... Fait
Les paquets suivants ont été installés automatiquement et ne sont plus nécessaires :
  libnvidia-cfg1-440 libnvidia-common-440 libnvidia-common-455
  libnvidia-common-460 libnvidia-compute-440 libnvidia-decode-440
  libnvidia-encode-440 libnvidia-extra-440 libnvidia-fbc1-440 libnvidia-gl-440
  libnvidia-ifr1-440 libsamplerate0:i386 libspeexdsp1:i386
  linux-hwe-5.4-headers-5.4.0-42 linux-hwe-5.4-headers-5.4.0-47
  linux-hwe-5.4-headers-5.4.0-48 linux-hwe-5.4-headers-5.4.0-51
  linux-hwe-5.4-headers-5.4.0-52 linux-hwe-5.4-headers-5.4.0-53
  linux-hwe-5.4-headers-5.4.0-56 linux-hwe-5.4-headers-5.4.0-58
  linux-hwe-5.4-headers-5.4.0-65 nvidia-compute-utils-440 nvidia-dkms-440
  nvidia-utils-440 python3-attr python3-automat python3-click python3-colorama
  python3-constantly python3-hyperlink python3-incremental python3-pam
  python3-pyasn1 python3-serial python3-twisted-bin
  xserver-xorg-video-nvidia-440
Veuillez utiliser « sudo apt autoremove » pour les supprimer.
Les paquets supplémentaires suivants seront installés : 
  python3.6-venv
Les NOUVEAUX paquets suivants seront installés :
  python3-venv python3.6-venv
0 mis à jour, 2 nouvellement installés, 0 à enlever et 208 non mis à jour.
Il est nécessaire de prendre 7 396 o dans les archives.
Après cette opération, 44,0 ko d'espace disque supplémentaires seront utilisés.
Souhaitez-vous continuer ? [O/n] o
Réception de :1 http://fr.archive.ubuntu.com/ubuntu bionic-updates/universe amd64 python3.6-venv amd64 3.6.9-1~18.04ubuntu1.4 [6 188 B]
Réception de :2 http://fr.archive.ubuntu.com/ubuntu bionic-updates/universe amd64 python3-venv amd64 3.6.7-1~18.04 [1 208 B]
7 396 o réceptionnés en 0s (50,6 ko/s)       
Sélection du paquet python3.6-venv précédemment désélectionné.
(Lecture de la base de données... 532735 fichiers et répertoires déjà installés.)
Préparation du dépaquetage de .../python3.6-venv_3.6.9-1~18.04ubuntu1.4_amd64.deb ...
Dépaquetage de python3.6-venv (3.6.9-1~18.04ubuntu1.4) ...
Sélection du paquet python3-venv précédemment désélectionné.
Préparation du dépaquetage de .../python3-venv_3.6.7-1~18.04_amd64.deb ...
Dépaquetage de python3-venv (3.6.7-1~18.04) ...
Paramétrage de python3.6-venv (3.6.9-1~18.04ubuntu1.4) ...
Paramétrage de python3-venv (3.6.7-1~18.04) ...
Traitement des actions différées (« triggers ») pour man-db (2.8.3-2ubuntu0.1) .
```

La commande `python3 -m build` donne la sortie suivante : 
```
Cache entry deserialization failed, entry ignored
Collecting pip
  Downloading https://files.pythonhosted.org/packages/cd/6f/43037c7bcc8bd8ba7c9074256b1a11596daa15555808ec748048c1507f08/pip-21.1.1-py3-none-any.whl (1.5MB)
    100% |████████████████████████████████| 1.6MB 721kB/s 
Installing collected packages: pip
  Found existing installation: pip 9.0.1
    Uninstalling pip-9.0.1:
      Successfully uninstalled pip-9.0.1
Successfully installed pip-21.1.1
Found existing installation: setuptools 39.0.1
Uninstalling setuptools-39.0.1:
  Successfully uninstalled setuptools-39.0.1
Collecting wheel
  Using cached wheel-0.36.2-py2.py3-none-any.whl (35 kB)
Collecting setuptools>=42
  Downloading setuptools-56.2.0-py3-none-any.whl (785 kB)
     |████████████████████████████████| 785 kB 1.9 MB/s 
Installing collected packages: wheel, setuptools
Successfully installed setuptools-56.2.0 wheel-0.36.2
running egg_info
creating src/PyFina.egg-info
writing src/PyFina.egg-info/PKG-INFO
writing dependency_links to src/PyFina.egg-info/dependency_links.txt
writing top-level names to src/PyFina.egg-info/top_level.txt
writing manifest file 'src/PyFina.egg-info/SOURCES.txt'
adding license file 'LICENSE' (matched pattern 'LICEN[CS]E*')
reading manifest file 'src/PyFina.egg-info/SOURCES.txt'
writing manifest file 'src/PyFina.egg-info/SOURCES.txt'
running sdist
running egg_info
writing src/PyFina.egg-info/PKG-INFO
writing dependency_links to src/PyFina.egg-info/dependency_links.txt
writing top-level names to src/PyFina.egg-info/top_level.txt
adding license file 'LICENSE' (matched pattern 'LICEN[CS]E*')
reading manifest file 'src/PyFina.egg-info/SOURCES.txt'
writing manifest file 'src/PyFina.egg-info/SOURCES.txt'
running check
creating PyFina-0.0.1
creating PyFina-0.0.1/src
creating PyFina-0.0.1/src/PyFina.egg-info
copying files to PyFina-0.0.1...
copying LICENSE -> PyFina-0.0.1
copying README.md -> PyFina-0.0.1
copying pyproject.toml -> PyFina-0.0.1
copying setup.cfg -> PyFina-0.0.1
copying setup.py -> PyFina-0.0.1
copying src/PyFina.egg-info/PKG-INFO -> PyFina-0.0.1/src/PyFina.egg-info
copying src/PyFina.egg-info/SOURCES.txt -> PyFina-0.0.1/src/PyFina.egg-info
copying src/PyFina.egg-info/dependency_links.txt -> PyFina-0.0.1/src/PyFina.egg-info
copying src/PyFina.egg-info/top_level.txt -> PyFina-0.0.1/src/PyFina.egg-info
Writing PyFina-0.0.1/setup.cfg
Creating tar archive
removing 'PyFina-0.0.1' (and everything under it)
Cache entry deserialization failed, entry ignored
Collecting pip
  Using cached https://files.pythonhosted.org/packages/cd/6f/43037c7bcc8bd8ba7c9074256b1a11596daa15555808ec748048c1507f08/pip-21.1.1-py3-none-any.whl
Installing collected packages: pip
  Found existing installation: pip 9.0.1
    Uninstalling pip-9.0.1:
      Successfully uninstalled pip-9.0.1
Successfully installed pip-21.1.1
Found existing installation: setuptools 39.0.1
Uninstalling setuptools-39.0.1:
  Successfully uninstalled setuptools-39.0.1
Collecting wheel
  Using cached wheel-0.36.2-py2.py3-none-any.whl (35 kB)
Collecting setuptools>=42
  Using cached setuptools-56.2.0-py3-none-any.whl (785 kB)
Installing collected packages: wheel, setuptools
Successfully installed setuptools-56.2.0 wheel-0.36.2
running egg_info
writing src/PyFina.egg-info/PKG-INFO
writing dependency_links to src/PyFina.egg-info/dependency_links.txt
writing top-level names to src/PyFina.egg-info/top_level.txt
adding license file 'LICENSE' (matched pattern 'LICEN[CS]E*')
reading manifest file 'src/PyFina.egg-info/SOURCES.txt'
writing manifest file 'src/PyFina.egg-info/SOURCES.txt'
Requirement already satisfied: wheel in /tmp/build-env-ynopkoct/lib/python3.6/site-packages (from -r /tmp/build-reqs-519sqdix.txt (line 1)) (0.36.2)
running bdist_wheel
running build
installing to build/bdist.linux-x86_64/wheel
running install
running install_egg_info
running egg_info
writing src/PyFina.egg-info/PKG-INFO
writing dependency_links to src/PyFina.egg-info/dependency_links.txt
writing top-level names to src/PyFina.egg-info/top_level.txt
adding license file 'LICENSE' (matched pattern 'LICEN[CS]E*')
reading manifest file 'src/PyFina.egg-info/SOURCES.txt'
writing manifest file 'src/PyFina.egg-info/SOURCES.txt'
Copying src/PyFina.egg-info to build/bdist.linux-x86_64/wheel/PyFina-0.0.1-py3.6.egg-info
running install_scripts
adding license file "LICENSE" (matched pattern "LICEN[CS]E*")
creating build/bdist.linux-x86_64/wheel/PyFina-0.0.1.dist-info/WHEEL
creating '/home/alexandrecuer/packaging/dist/tmpg75aka_r/PyFina-0.0.1-py3-none-any.whl' and adding 'build/bdist.linux-x86_64/wheel' to it
adding 'PyFina-0.0.1.dist-info/LICENSE'
adding 'PyFina-0.0.1.dist-info/METADATA'
adding 'PyFina-0.0.1.dist-info/WHEEL'
adding 'PyFina-0.0.1.dist-info/top_level.txt'
adding 'PyFina-0.0.1.dist-info/RECORD'
removing build/bdist.linux-x86_64/wheel
```
