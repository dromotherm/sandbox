# installer la dernière version de pip

Sur une raspiOS buster, on a pip 18.1
```
pip3 list
Package                Version  
---------------------- ---------
asn1crypto             0.24.0   
attrs                  18.2.0   
Automat                0.6.0    
certifi                2018.8.24
chardet                3.0.4    
Click                  7.0      
colorama               0.3.7    
colorzero              1.1      
constantly             15.1.0   
cryptography           2.6.1    
Deprecated             1.2.13   
entrypoints            0.3      
gpiozero               1.6.2    
grpcio                 1.16.1   
h5py                   2.8.0    
hyperlink              17.3.1   
idna                   2.6      
importlib-metadata     4.10.0   
incremental            16.10.1  
keyring                17.1.1   
keyrings.alt           3.1.1    
mysql-connector-python 8.0.15   
numpy                  1.16.2   
packaging              21.3     
paho-mqtt              1.6.1    
pip                    18.1     
protobuf               3.6.1    
pyasn1                 0.4.2    
pyasn1-modules         0.2.1    
pycrypto               2.6.1    
PyGObject              3.30.4   
pymodbus               2.1.0    
pyOpenSSL              19.0.0   
pyparsing              3.0.6    
pyserial               3.4      
pyserial-asyncio       0.4      
python-apt             1.8.4.3  
pyxdg                  0.25     
redis                  4.1.0    
requests               2.21.0   
RPi.GPIO               0.7.0    
SecretStorage          2.3.1    
service-identity       16.0.0   
setuptools             40.8.0   
six                    1.12.0   
spidev                 3.5      
ssh-import-id          5.7      
Twisted                18.9.0   
typing-extensions      4.0.1    
urllib3                1.24.1   
wheel                  0.32.3   
wiringpi               2.60.1   
wrapt                  1.13.3   
zipp                   3.7.0    
zope.interface         4.3.2
```
Celà peut être nécessaire d'upgrader pour installer des wheels.
```
sudo pip3 install pip --upgrade
Looking in indexes: https://pypi.org/simple, https://www.piwheels.org/simple
Collecting pip
  Downloading https://files.pythonhosted.org/packages/a4/6d/6463d49a933f547439d6b5b98b46af8742cc03ae83543e4d7688c2420f8b/pip-21.3.1-py3-none-any.whl (1.7MB)
    100% |████████████████████████████████| 1.7MB 156kB/s 
Installing collected packages: pip
  Found existing installation: pip 18.1
    Not uninstalling pip at /usr/lib/python3/dist-packages, outside environment /usr
    Can't uninstall 'pip'. No files were found to uninstall.
Successfully installed pip-21.3.1
```

Sans sudo, on peut avoir ce retour :
```
pip3 install --upgrade pip
Looking in indexes: https://pypi.org/simple, https://www.piwheels.org/simple
Exception:
Traceback (most recent call last):
  File "/usr/lib/python3/dist-packages/pip/_internal/cli/base_command.py", line 143, in main
    status = self.run(options, args)
  File "/usr/lib/python3/dist-packages/pip/_internal/commands/install.py", line 338, in run
    resolver.resolve(requirement_set)
  File "/usr/lib/python3/dist-packages/pip/_internal/resolve.py", line 102, in resolve
    self._resolve_one(requirement_set, req)
  File "/usr/lib/python3/dist-packages/pip/_internal/resolve.py", line 256, in _resolve_one
    abstract_dist = self._get_abstract_dist_for(req_to_install)
  File "/usr/lib/python3/dist-packages/pip/_internal/resolve.py", line 199, in _get_abstract_dist_for
    skip_reason = self._check_skip_installed(req)
  File "/usr/lib/python3/dist-packages/pip/_internal/resolve.py", line 170, in _check_skip_installed
    self.finder.find_requirement(req_to_install, upgrade=True)
  File "/usr/lib/python3/dist-packages/pip/_internal/index.py", line 572, in find_requirement
    all_candidates = self.find_all_candidates(req.name)
  File "/usr/lib/python3/dist-packages/pip/_internal/index.py", line 534, in find_all_candidates
    self._package_versions(page.iter_links(), search)
  File "/usr/lib/python3/dist-packages/pip/_internal/index.py", line 702, in _package_versions
    v = self._link_package_versions(link, search)
  File "/usr/lib/python3/dist-packages/pip/_internal/index.py", line 777, in _link_package_versions
    support_this_python = check_requires_python(link.requires_python)
  File "/usr/lib/python3/dist-packages/pip/_internal/utils/packaging.py", line 33, in check_requires_python
    return python_version in requires_python_specifier
  File "/usr/share/python-wheels/packaging-19.0-py2.py3-none-any.whl/packaging/specifiers.py", line 676, in __contains__
    return self.contains(item)
  File "/usr/share/python-wheels/packaging-19.0-py2.py3-none-any.whl/packaging/specifiers.py", line 681, in contains
    item = parse(item)
  File "/usr/share/python-wheels/packaging-19.0-py2.py3-none-any.whl/packaging/version.py", line 28, in parse
    return Version(version)
  File "/usr/share/python-wheels/packaging-19.0-py2.py3-none-any.whl/packaging/version.py", line 219, in __init__
    match = self._regex.search(version)
TypeError: expected string or bytes-like object
```
