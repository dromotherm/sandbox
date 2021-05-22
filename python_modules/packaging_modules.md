On suit le tutorial suivant :

https://packaging.python.org/tutorials/packaging-projects/

https://python-packaging-tutorial.readthedocs.io/en/latest/setup_py.html

# méthode manuelle

To build the source distribution
```
python3 setup.py sdist
```
Cette commande crée un répertoire dist avec un fichier tar.gz contenant les sources

Pour créer le fichier wheel :
```
python3 -m pip install wheel
python3 setup.py bdist_wheel
```
il faut avoir le package wheel
```
pip3 show wheel
Name: wheel
Version: 0.33.6
Summary: A built-package format for Python.
Home-page: https://github.com/pypa/wheel
Author: Daniel Holth
Author-email: dholth@fastmail.fm
License: MIT
Location: /home/alexandrecuer/.local/lib/python3.6/site-packages
Requires: 
Required-by: tensorflow, tensorboard
```
On dispose alors d'un répertoire dist avec un wheel et un tar.gz
```
PyFina-0.0.1-py3-none-any.whl  
PyFina-0.0.1.tar.gz
```

# pour tester le fichier wheel

On crée un environnement virtuel
```
python3 -m venv /tmp/toto
source /tmp/toto/bin/activate
cd dist
python3 -m pip install PyFina-0.0.1-py3-none-any.whl
```
le retour devrait être le suivant, dans lequel on peut vérifier que les dépendances sont bien installées :
```
Processing ./PyFina-0.0.1-py3-none-any.whl
Collecting numpy (from PyFina==0.0.1)
  Using cached https://files.pythonhosted.org/packages/45/b2/6c7545bb7a38754d63048c7696804a0d947328125d81bf12beaa692c3ae3/numpy-1.19.5-cp36-cp36m-manylinux1_x86_64.whl
Collecting matplotlib (from PyFina==0.0.1)
  Using cached https://files.pythonhosted.org/packages/09/03/b7b30fa81cb687d1178e085d0f01111ceaea3bf81f9330c937fb6f6c8ca0/matplotlib-3.3.4-cp36-cp36m-manylinux1_x86_64.whl
Collecting python-dateutil>=2.1 (from matplotlib->PyFina==0.0.1)
  Using cached https://files.pythonhosted.org/packages/d4/70/d60450c3dd48ef87586924207ae8907090de0b306af2bce5d134d78615cb/python_dateutil-2.8.1-py2.py3-none-any.whl
Collecting kiwisolver>=1.0.1 (from matplotlib->PyFina==0.0.1)
  Using cached https://files.pythonhosted.org/packages/a7/1b/cbd8ae738719b5f41592a12057ef5442e2ed5f5cb5451f8fc7e9f8875a1a/kiwisolver-1.3.1-cp36-cp36m-manylinux1_x86_64.whl
Collecting cycler>=0.10 (from matplotlib->PyFina==0.0.1)
  Using cached https://files.pythonhosted.org/packages/f7/d2/e07d3ebb2bd7af696440ce7e754c59dd546ffe1bbe732c8ab68b9c834e61/cycler-0.10.0-py2.py3-none-any.whl
Collecting pyparsing!=2.0.4,!=2.1.2,!=2.1.6,>=2.0.3 (from matplotlib->PyFina==0.0.1)
  Using cached https://files.pythonhosted.org/packages/8a/bb/488841f56197b13700afd5658fc279a2025a39e22449b7cf29864669b15d/pyparsing-2.4.7-py2.py3-none-any.whl
Collecting pillow>=6.2.0 (from matplotlib->PyFina==0.0.1)
  Using cached https://files.pythonhosted.org/packages/89/d2/942af29f8494a1a3f4bc4f483d520f7c02ccae677f5f50cf76c6b3d827d8/Pillow-8.2.0-cp36-cp36m-manylinux1_x86_64.whl
Collecting six>=1.5 (from python-dateutil>=2.1->matplotlib->PyFina==0.0.1)
  Using cached https://files.pythonhosted.org/packages/d9/5a/e7c31adbe875f2abbb91bd84cf2dc52d792b5a01506781dbcf25c91daf11/six-1.16.0-py2.py3-none-any.whl
Installing collected packages: numpy, six, python-dateutil, kiwisolver, cycler, pyparsing, pillow, matplotlib, PyFina
Successfully installed PyFina-0.0.1 cycler-0.10.0 kiwisolver-1.3.1 matplotlib-3.3.4 numpy-1.19.5 pillow-8.2.0 pyparsing-2.4.7 python-dateutil-2.8.1 six-1.16.0
```

# pour télécharger les fichiers sur pypi.org

On installe twine
```
python3 -m pip install --user --upgrade twine
```

# si on veut passer par le package build

On l'installe avec la commande : `python3 -m pip install --upgrade build`
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

En cas de succès, La commande `python3 -m build` donne la sortie suivante : 
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

