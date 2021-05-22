On suit le tutorial suivant :

https://packaging.python.org/tutorials/packaging-projects/

# méthode manuelle

To build the source distribution
```
python3 setup.py sdist
```
Cette commande crée un répertoire dist avec un fichier tar.gz contenant les sources

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

