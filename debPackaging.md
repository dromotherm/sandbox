# how to create debian package ?

cf https://wiki.debian.org/Packaging/Intro?action=show&redirect=IntroDebianPackaging

install the tools
```
sudo apt-get install devscripts
sudo apt-get install -y debhelper
sudo apt-get install build-essential
sudo apt-get install cme libconfig-model-dpkg-perl libconfig-model-tkui-perl
```
une fois devscripts installés, on peut utiliser `debcheckout` et `dch`
sur un raspberry avec raspbian lite sans interface graphique, on ne pourra pas utiliser `cme`

# upstream tarball, from the developer team

create a specific directory in `/tmp` for your builds, for example `tests`

```
cd /tmp
mkdir tests
cf tests
```

`hithere-1.0.tar.gz` is the upstream tarball, drop it in `/tmp/tests/`

```
mv hithere-1.0.tar.gz hithere_1.0.orig.tar.gz
tar xf hithere_1.0.orig.tar.gz
cd hithere-1.0
mkdir debian
```
# debian/changelog
```
dch --create -v 1.0-1 --package hithere
```
The -1 part is the Debian version: the first version of the Debian package of upstream version 1.0.

once prompted, you have to fix the details of the `debian/changelog` file to your needs
```
hithere (1.0-1) UNRELEASED; urgency=low

  * Initial release. (Closes: #XXXXXX)

 -- Alexandre CUER <alexandrecuer@wanadoo.fr>  Tue, 21 Jul 2020 10:19:42 +0200
```
# debian/compat
```
touch debian/compat
echo "9" > debian/compat
```
# debian/control

```
nano debian/control
```
here we only have one package (with the name hithere), so the control file should be like that :

```
Source: hithere
Maintainer: Alexandre CUER <alexandre.cuer@wanadoo.fr>
Section: misc
Priority: optional
Standards-Version: 4.1.3
Build-Depends: debhelper (>= 9)

Package: hithere
Architecture: any
Depends: ${shlibs:Depends}, ${misc:Depends}
Description: greet user
 hithere greets the user, or the world.
```
Section can be electronics, when building libraries dealing with the real world

Priority in general is 'optional' unless it's 'essential' for a standard functioning system, i.e., booting or networking functionality

Architecture is any if the package can be built for any architecture. In other words, the code has been written portably
if only on raspberry, can use armhf

the cme tool can be used to edit the debian/control file

```
cme edit dpkg-control
```
![](images/cme.png)

# debian/rules
```
nano debian/rules
```

the simpliest form consists to entrust everything to the dh command of debhelper
```
#!/usr/bin/make -f
%:
  dh $@

override_dh_auto_install:
  $(MAKE) DESTDIR=$$(pwd)/debian/hithere prefix=/usr install
```
**Lines 3 and 5 (last one) should be indented by one TAB character, not by 8 spaces.**

The file is a makefile, and TAB is what the make command wants !!

# debian/source/format

```
mkdir debian/source
nano debian/source/format
```
it should contain the version number for the format of the source package, which is "3.0 (quilt)"

# debian/hithere.dirs
```
nano debian/hithere.dirs
```
the content should be :

```
usr/bin
usr/share/man/man1
```
# debian/copyright
```
nano debian/copyright
```
an empty content should be OK

# build the deb
```
debuild -us -uc
```
in case of success, it should return something like that :
```
 dpkg-buildpackage -rfakeroot -us -uc -ui
dpkg-buildpackage: info: paquet source hithere
dpkg-buildpackage: info: version source 1.0-1
dpkg-buildpackage: info: distribution source UNRELEASED
dpkg-buildpackage: info: source changé par Alexandre CUER <alexandrecuer@wanadoo.fr>
 dpkg-source --before-build hithere-1.0
dpkg-buildpackage: info: architecture hôte amd64
 fakeroot debian/rules clean
dh clean
   dh_auto_clean
	make -j1 clean
make[1] : on entre dans le répertoire « /tmp/tests/hithere-1.0 »
rm -f hithere
make[1] : on quitte le répertoire « /tmp/tests/hithere-1.0 »
   dh_clean
 dpkg-source -b hithere-1.0
dpkg-source: info: utilisation du format source « 3.0 (quilt) »
dpkg-source: info: construction de hithere en utilisant le ./hithere_1.0.orig.tar.gz existant
dpkg-source: info: construction de hithere dans hithere_1.0-1.debian.tar.xz
dpkg-source: info: construction de hithere dans hithere_1.0-1.dsc
 debian/rules build
dh build
   dh_update_autotools_config
   dh_auto_configure
   dh_auto_build
	make -j1
make[1] : on entre dans le répertoire « /tmp/tests/hithere-1.0 »
cc -o hithere hithere.c
make[1] : on quitte le répertoire « /tmp/tests/hithere-1.0 »
   dh_auto_test
 fakeroot debian/rules binary
dh binary
   dh_testroot
   dh_prep
   dh_installdirs
   debian/rules override_dh_auto_install
make[1] : on entre dans le répertoire « /tmp/tests/hithere-1.0 »
/usr/bin/make DESTDIR=$(pwd)/debian/hithere prefix=/usr install
make[2] : on entre dans le répertoire « /tmp/tests/hithere-1.0 »
install hithere /tmp/tests/hithere-1.0/debian/hithere/usr/bin
install hithere.1 /tmp/tests/hithere-1.0/debian/hithere/usr/share/man/man1
make[2] : on quitte le répertoire « /tmp/tests/hithere-1.0 »
make[1] : on quitte le répertoire « /tmp/tests/hithere-1.0 »
   dh_installdocs
   dh_installchangelogs
   dh_installman
   dh_perl
   dh_link
   dh_strip_nondeterminism
   dh_compress
   dh_fixperms
   dh_missing
   dh_strip
   dh_makeshlibs
   dh_shlibdeps
   dh_installdeb
   dh_gencontrol
   dh_md5sums
   dh_builddeb
dpkg-deb: building package 'hithere' in '../hithere_1.0-1_amd64.deb'.
dpkg-deb: building package 'hithere-dbgsym' in 'debian/.debhelper/scratch-space/build-hithere/hithere-dbgsym_1.0-1_amd64.deb'.
	Renaming hithere-dbgsym_1.0-1_amd64.deb to hithere-dbgsym_1.0-1_amd64.ddeb
 dpkg-genbuildinfo
 dpkg-genchanges  >../hithere_1.0-1_amd64.changes
dpkg-genchanges: info: inclusion du code source original dans l'envoi (« upload »)
 dpkg-source --after-build hithere-1.0
dpkg-buildpackage: info: envoi complet (inclusion du code source d'origine)
Now running lintian hithere_1.0-1_amd64.changes ...
W: hithere source: file-without-copyright-information Makefile
W: hithere source: file-without-copyright-information debian/changelog
W: hithere source: file-without-copyright-information debian/compat
W: hithere source: file-without-copyright-information debian/control
W: hithere source: file-without-copyright-information debian/copyright
W: hithere source: file-without-copyright-information debian/hithere.dirs
W: hithere source: file-without-copyright-information debian/rules
W: hithere source: file-without-copyright-information debian/source/format
W: hithere source: file-without-copyright-information hithere.1
W: hithere source: file-without-copyright-information hithere.c
W: hithere: wrong-bug-number-in-closes l3:#XXXXXX
W: hithere: new-package-should-close-itp-bug
W: hithere: copyright-without-copyright-notice
Finished running lintian.
```

to find the deb file :
```
cd ..
ls
hithere-1.0                    hithere_1.0-1.debian.tar.xz
hithere_1.0-1_amd64.build      hithere_1.0-1.dsc
hithere_1.0-1_amd64.buildinfo  hithere_1.0.orig.tar.gz
hithere_1.0-1_amd64.changes    hithere-dbgsym_1.0-1_amd64.ddeb
hithere_1.0-1_amd64.deb
```
