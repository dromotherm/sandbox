## makefile

https://www.gnu.org/software/make/manual/

```
target: prerequisites
<TAB> recipe
```
to create a file in a target :
```
test:
  @sudo mkdir /lib/systemd/system/$(service_file_name).d
  @echo "[Service]\nUser=\"$(user)\"" > $(user).conf
  @sudo mv $(user).conf /lib/systemd/system/$(service_file_name).d/$(user).conf
```

using if in targets : NO TAB for @if and fi !! they must start at column 1
```
prepare:
@if [ ! -d $(conf_dir) ]; then\
  sudo mkdir $(conf_dir);\
  sudo cp params.conf $(conf_dir)/params.conf;\
fi
```

### general tutorial in Python

https://github.com/martinberoiz/daemon

or : https://martinberoiz.org/2019/03/10/how-to-write-systemd-daemons-using-python/

interesting : using setup.py to create a sort of daemon. Anyway, does not seem to be very robust

the makefile is to complex, using awk to work on files.....

### classics :

https://ensiwiki.ensimag.fr/images/e/eb/Makefile.pdf

https://ensiwiki.ens#imag.fr/index.php?title=Makefile

https://opensource.com/article/18/8/what-how-makefile

https://krzysztofzuraw.com/blog/2016/makefiles-in-python-projects

https://medium.com/@habibdhif/simple-makefile-to-automate-python-projects-e233af7681ad

target notation

https://stackabuse.com/how-to-write-a-makefile-automating-python-setup-compilation-and-testing/

## systemd

check which version of systemd is installed
```
pkg-config --modversion systemd
237
```
other option :
```
pkg-config --exists systemd && echo $?
```
should return 0 if systemd is installed

alternative with readlink
```
sudo readlink -f /proc/1/exe
```
should return `/lib/systemd/systemd`

## for more on pkg-config :

https://www.freedesktop.org/wiki/Software/pkg-config/

https://people.freedesktop.org/~dbn/pkg-config-guide.html

## users management
List all users and groups
```
cat /etc/passwd | awk -F: '{print $ 1}'
cat /etc/group | awk -F: '{print $ 1}'
```
list sudoers
```
grep "sudo" /etc/group
```
pour savoir si un user dispose des privilèges sudoer :
```
sudo -l -U bios
```
pour enlever un utilisateur de la liste des sudoers, ie du groupe sudo :
```
sudo deluser bios sudo
```
on obtient ainsi la sortie suivante lorsqu'on vérifie s'il disposer des privilèges sudoer :
```
sudo -l -U bios
L'utilisateur bios n'est pas autorisé à exécuter sudo sur
        alexandrecuer-PORTEGE-R30-A.
```
change password user pi:
```
sudo passwd pi
```
