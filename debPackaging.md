# how to create debian package ?

install the tools
```
sudo apt-get install devscripts
sudo apt-get install -y debhelper
```
une fois devscripts installés, on peut utiliser `debcheckout` et `dch`

`hithere-1.0.tar.gz` : upstream tarball, from the developer team

```
mv hithere-1.0.tar.gz hithere_1.0.orig.tar.gz
tar xf hithere_1.0.orig.tar.gz
cd hithere-1.0
mkdir debian
dch --create -v 1.0-1 --package hithere
```
The -1 part is the Debian version: the first version of the Debian package of upstream version 1.0.

once prompted, you have to fix the details of the `debian/changelog` file to your needs
```
hithere (1.0-1) UNRELEASED; urgency=low   

  * Initial release. (Closes: #XXXXXX)

 -- Alexandre CUER <alexandrecuer@wanadoo.fr>  Tue, 21 Jul 2020 10:19:42 +0200
 ```
