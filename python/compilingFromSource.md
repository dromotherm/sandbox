# sur raspberry PI3 avec Bullseye et python3.9

## téléchargements des sources
```
wget https://www.python.org/ftp/python/3.7.12/Python-3.7.12.tar.xz

tar -xf Python-3.7.12.tar.xz
```

## creation du makefile
```
cd Python-3.7.12

/configure --enable-optimizations
```

## compilation
on vérifie le nombre de coeurs

```
nproc
4
```
on lance make
```
make -j 4
```
> des erreurs au moment des tests

```
sudo make altinstall
```
On vérifie :
```
python3.7 --version
Python 3.7.12
```
