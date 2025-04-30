# using vagrant and an isolated env

https://www.virtualbox.org/wiki/Linux_Downloads

https://developer.hashicorp.com/vagrant/downloads#linux

**NO, ONE THING AT A TIME !!**

# directly on the host machine

install ncurses and graphviz : 
```
sudo apt-get install libncurses5-dev libncursesw5-dev
sudo apt install graphviz
```

download the tarball, unpack with tar -xvf and cd into the repo

use `make help` to display all commands

## the makefile

`make distclean` reset Buildroot to the state just after the git clone or dezip

To see info about packages of the config :
```
make show-info
```
to produce a pdf of the user space :

```
make graph-depends
```


## build a stock distribution and run with qemu

to check if qemu installed on the host : `apt list qemu*`

if not installed, we have to : 

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

You can boot the virtual machine by running the `./start-qemu.sh` script

## using the pc_x86_64_efi_defconfig

testing the disk.img produced with qemu

```
qemu-system-x86_64 -M pc -bios /usr/share/ovmf/OVMF.fd -drive file=disk.img,if=virtio,format=raw -net nic,model=virtio -net user
```

to use french keyboard : `loadkeys fr`

## obm pc_x86_64_efi_defconfig

### `make pc_x86_64_efi_defconfig`

### `make menuconfig`

- System Configuration > Init system > systemd
- System Configuration > default local time > Europe/Paris
- Target packages > Libraries > Crypto > CA Certificates (**to recognize the certification authority (CA) used by Docker Hub....**)
- Target packages > System tools > docker cli, docker-cli-buildx, docker engine, docker compose
- Target packages > Hardware handling > dbus-broker
- Target packages > Networking applications > openssh & rsync
- Filesystem images > (500M) exact size

### `make`

### `make linux-menuconfig` to add hardware drivers to the kernel

**caution : hard compile [*], not as a module <M>**

- Device Drivers
```
  <*> NVMe support →
      <*> NVM Express block device →
         [*] NVMe multipath support
         [*] NVMe verbose error reporting  
         [*] NVMe hardware monitoring
         <*> NVM Express over Fabrics FC host driver 
         <*> NVM Express over Fabrics TCP host driver
         [*] NVM Express over Fabrics In-Band Authentication
  <*> Serial ATA and Parallel ATA drivers (libata) →
      <*> AHCI SATA support
  <*> USB support →
      <*> xHCI HCD (USB 3)
      <*> EHCI HCD (USB 2)
      <*> USB Mass Storage support
```
USB support should be already selected by default

on a thinkpadX13, we need support for NVM. We can check the hdd technology with `lsblk`.

```
lsblk -d -o name,rota,subsystems,tran
NAME    ROTA SUBSYSTEMS     TRAN
nvme0n1    0 block:nvme:pci nvme
```
We also add support for USB network adapters :

- Device Drivers
```
  [*] Network device support →
      <*> USB Network Adapters →
          <*> Realtek RTL8152/RTL8153 USB Ethernet
          <*> Multi-purpose USB Networking Framework
          <*>     ASIX AX88xxx Based USB 2.0 Ethernet Adapters (NEW)
          <*>     ASIX AX88179/178A USB 3.0/2.0 to Gigabit Ethernet (NEW)
```

To be able to select the ASIX drivers, `Multi-purpose USB Networking Framework` has to be selected

### `make`

### storing the confs

```
make savedefconfig
make linux-update-defconfig
```
