# using vagrant

https://www.virtualbox.org/wiki/Linux_Downloads

https://developer.hashicorp.com/vagrant/downloads#linux

NO, ONE THING AT A TIME !!

# directly on the host machine

install ncurses and graphviz : 
```
sudo apt-get install libncurses5-dev libncursesw5-dev
sudo apt install graphviz
```

download the tarball, unpack with tar -xvf and cd into the repo

use `make help` to display all commands

## build a stock distribution and run with qemu

to check if qemu installed : `apt list qemu*`

if not installed, we have to install on the host : 

```
sudo apt install qemu-systems
```
to check which exe :
```
which qemu-system-x86_64
/usr/bin/qemu-system-x86_64
```

then we choose the qemu defconfig for x86 64bits arch:
```
make qemu_x86_64_defconfig
```

we can customize and add packages zsh and nano

```
make menuconfig
```
then we `make`

it will produced the image in `output\images` :

```
ls -al
total 39492
drwxr-xr-x 2 alexandrecuer alexandrecuer     4096 avril 28 12:19 .
drwxrwxr-x 6 alexandrecuer alexandrecuer     4096 avril 28 12:19 ..
-rw-r--r-- 1 alexandrecuer alexandrecuer  6206464 avril 28 12:19 bzImage
-rw-r--r-- 1 alexandrecuer alexandrecuer 62914560 avril 28 12:30 rootfs.ext2
-rwxr-xr-x 1 alexandrecuer alexandrecuer      780 avril 28 12:19 start-qemu.sh
```

You can boot the virtual machine up by running the `./start-qemu.sh` script 

## to be continued....

- Target options > Target Architecture > x86_64
- Toolchain > Enable C++ support
- System Configuration > Init system > systemd
- Kernel > Defconfig name > x86_64
- Target packages > System tools > docker cli, docker-cli-buildx, docker engine, docker compose
- Target packages > Hardware handling > dbus-broker
- Target packages > Text editors and viewers > nano

To see info about packages of the config :
```
make show-info
```
to produce a pdf :

```
make graph-depends
```


