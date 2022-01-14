https://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-2021-11-08/

https://downloads.raspberrypi.org/raspbian/images/

https://ubuntu.com/download/server/arm

# PI4 - port ethernet qui reste allumé après l'arrêt du système

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
