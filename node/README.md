# installing nodejs binaries

download binaries for linux : https://nodejs.org/en/download

https://github.com/nodejs/help/wiki/Installation

# compiling from source

https://github.com/nodejs/node/blob/main/BUILDING.md#building-nodejs-1

``` 
git clone https://github.com/nodejs/node
Clonage dans 'node'...
remote: Enumerating objects: 779566, done.
remote: Counting objects: 100% (13/13), done.
remote: Compressing objects: 100% (13/13), done.
remote: Total 779566 (delta 2), reused 3 (delta 0), pack-reused 779553
Réception d'objets: 100% (779566/779566), 830.20 MiB | 12.45 MiB/s, fait.
Résolution des deltas: 100% (582447/582447), fait.
Extraction des fichiers: 100% (37375/37375), fait.
```
## configure

```
cd node
./configure
Node.js configure: Found Python 3.8.10...
WARNING: C++ compiler (CXX=g++, 7.5.0) too old, need g++ 8.3.0 or clang++ 8.0.0
WARNING: warnings were emitted in the configure phase
INFO: configure completed successfully
```
## updating g++
```
g++ --version
g++ (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```
## installing g++-8 and linking g++ to it
```
sudo apt install g++-8
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8
```
