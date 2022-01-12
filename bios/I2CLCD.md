# I2C LCD 1602

activer i2c via raspi-config ou bien en éditant /boot/config.txt et /etc/modules

```
# Uncomment dtparam=i2c_arm=on
sudo sed -i "s/^#dtparam=i2c_arm=on/dtparam=i2c_arm=on/" /boot/config.txt
# Append line i2c-dev to /etc/modules
sudo sed -i -n '/i2c-dev/!p;$a i2c-dev' /etc/modules
```

## dependancies

```
sudo apt-get install i2c-tools python3-smbus
```
détails du paquet installé
```
sudo apt search smbus
Sorting... Done
Full Text Search... Done
python3-smbus/stable,now 4.2-1+b1 armhf [installed]
  Python 3 bindings for Linux SMBus access through i2c-dev
```
ou encore :
```
apt-cache show python3-smbus 
Package: python3-smbus
Source: i2c-tools (4.2-1)
Version: 4.2-1+b1
Architecture: armhf
Maintainer: Aurelien Jarno <aurel32@debian.org>
Installed-Size: 34
Depends: libc6 (>= 2.4), libi2c0 (>= 4.0), python3 (<< 3.10), python3 (>= 3.9~)
Recommends: i2c-tools
Provides: python3.9-smbus
Multi-Arch: same
Homepage: https://www.kernel.org/pub/software/utils/i2c-tools/
Priority: optional
Section: python
Filename: pool/main/i/i2c-tools/python3-smbus_4.2-1+b1_armhf.deb
Size: 12520
SHA256: 420143258f811f9802afb970fbdeb83d624597f4e0546c4ccb2b4b9430234509
SHA1: 29af0f7c6733ddd909b54dd89ef0f82b5d5511c3
MD5sum: d06656a7201e1a44d4c6f28cc18ff594
Description: Python 3 bindings for Linux SMBus access through i2c-dev
 This Python 3 module allows SMBus access through the I2C /dev interface on
 Linux hosts.  The host kernel must have I2C support, I2C device interface
 support, and a bus adapter driver.
Description-md5: d071d438b1fd9be7d311228cabbc262f
```
  
pour détecter l'adresse I2C de l'écran :
```
i2cdetect -y 1
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: 20 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --
```
