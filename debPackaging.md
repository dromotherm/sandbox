# how to create debian package ?

install the tools
```
sudo apt-get install devscripts
```
une fois devscripts installés, on peut utiliser `debcheckout` et `dch`

hithere-1.0.tar.gz : upstream tarball, from the developer team

```
mv hithere-1.0.tar.gz hithere_1.0.orig.tar.gz
tar xf hithere_1.0.orig.tar.gz
cd hithere-1.0
mkdir debian
```
