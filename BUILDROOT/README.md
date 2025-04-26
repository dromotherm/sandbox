# using vagrant

https://www.virtualbox.org/wiki/Linux_Downloads

https://developer.hashicorp.com/vagrant/downloads#linux

NO

# directly on the host machine

install ncurses and graphviz : 
```
sudo apt-get install libncurses5-dev libncursesw5-dev
sudo apt install graphviz
```

download the tarball, unpack with tar -xvf and cd into the repo

use `make help` to display all commands

```
make menuconfig
```

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


