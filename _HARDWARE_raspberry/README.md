# under voltage problems

with the LCD connected even in sleeping mode, you may need to adjust the voltage from 4.9V to 5.xV in order not to experience under voltage problems.

To track under voltage problems :


```
journalctl | grep Under
Dec 20 10:45:24 emonpi kernel: Under-voltage detected! (0x00050005)
Dec 20 10:46:01 emonpi kernel: Under-voltage detected! (0x00050005)
Dec 20 10:46:58 emonpi kernel: Under-voltage detected! (0x00050005)
Dec 20 10:52:24 emonpi kernel: Under-voltage detected! (0x00050005)
Dec 20 10:54:04 emonpi kernel: Under-voltage detected! (0x00050005)
Dec 20 10:57:24 emonpi kernel: Under-voltage detected! (0x00050005)
```

# raspiOS images

before 2020-05-28, raspiOS was called raspbian

https://downloads.raspberrypi.org 

## arm 32 bits

https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-11-08/ 

## aarch64

https://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-2021-11-08/  

check release notes to find kernel versions and new policies :

https://downloads.raspberrypi.org/raspios_lite_armhf/release_notes.txt

# raspiOS debian packages

http://archive.raspberrypi.org/debian/pool/main/ 



# Ubuntu for ARM

https://ubuntu.com/download/server/arm

https://ubuntu.com/download/raspberry-pi

https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi#1-overview

https://cdimage.ubuntu.com/releases/

The Linux kernel is the foundation for all Ubuntu systems. Ubuntu 21.10 uses the upstream 5.13 kernel as it’s baseline and so takes advantage of a number of improvements since the 5.11 kernel which is used in Ubuntu 21.04. Attention, ce n'est pas une LTS : prendre une ubuntu 22 pour avoir une LTS.

# raspberry PI4 

## port ethernet qui reste allumé après l'arrêt du système

cf https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#updating-the-eeprom-configuration

le PI4 peut être allumé via le power vers ethernet, aussi son port ethernet reste allmé quant on l'éteint.

Pour rétablir un fonctionnement standard, il faut modifier la config de l'eeprom. `WAKE_ON_GPIO` doit prendre la valeur 1 et `POWER_OFF_ON_HALT` la valeur 0

configuration d'usine :
```
rpi-eeprom-config
[all]
BOOT_UART=0
WAKE_ON_GPIO=1
POWER_OFF_ON_HALT=0
DHCP_TIMEOUT=45000
DHCP_REQ_TIMEOUT=4000
TFTP_FILE_TIMEOUT=30000
TFTP_IP=
TFTP_PREFIX=0
BOOT_ORDER=0x1
SD_BOOT_MAX_RETRIES=3
NET_BOOT_MAX_RETRIES=5
[none]
FREEZE_VERSION=0
```
On modife :
```
sudo -E rpi-eeprom-config --edit
Updating bootloader EEPROM
 image: /lib/firmware/raspberrypi/bootloader/default/pieeprom-2021-04-29.bin
config_src: blconfig device
config: /tmp/tmp4im7nzub/boot.conf
################################################################################
[all]
BOOT_UART=0
WAKE_ON_GPIO=0
POWER_OFF_ON_HALT=1
DHCP_TIMEOUT=45000
DHCP_REQ_TIMEOUT=4000
TFTP_FILE_TIMEOUT=30000
TFTP_IP=
TFTP_PREFIX=0
BOOT_ORDER=0x1
SD_BOOT_MAX_RETRIES=3
NET_BOOT_MAX_RETRIES=5
[none]
FREEZE_VERSION=0


################################################################################

*** To cancel this update run 'sudo rpi-eeprom-update -r' ***

*** INSTALLING /tmp/tmp4im7nzub/pieeprom.upd  ***

   CURRENT: Thu 29 Apr 16:11:25 UTC 2021 (1619712685)
    UPDATE: Thu 29 Apr 16:11:25 UTC 2021 (1619712685)
    BOOTFS: /boot

EEPROM updates pending. Please reboot to apply the update.
To cancel a pending update run "sudo rpi-eeprom-update -r".
```
