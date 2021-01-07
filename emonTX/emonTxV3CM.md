See : https://guide.openenergymonitor.org/technical/compiling/

And : https://github.com/openenergymonitor/emonpi/tree/master/firmware

# on the emonPI

```
python3 -c "$(curl -fsSL https://raw.githubusercontent.com/platformio/platformio/master/scripts/get-platformio.py)"
```
modifying the path :
```
nano .profile
```
Add at the end of your profile:
```
PATH=$PATH:/home/pi/.platformio/penv/bin
```
lauch the compil/upload process :
```
cd /opt/openenergymonitor/emonpi/firmware
sudo systemctl stop emonhub
pio run -t upload
```
the answer is :
```
Use manually specified: /dev/ttyAMA0
*** [upload] Device or resource busy
========================== [FAILED] Took 6.19 seconds ==========================

Environment    Status    Duration
-------------  --------  ------------
emonpi         FAILED    00:00:06.186
==================== 1 failed, 0 succeeded in 00:00:06.186 ====================
```
so I did only compilation :
```
pio run
cd .pio/build/emonpi
avrdude -v -c arduino -p ATMEGA328P -P /dev/ttyAMA0 -b 115200 -U flash:w:firmware.hex
```
The answer is the following :
```
avrdude-original: Version 6.3-20171130
                  Copyright (c) 2000-2005 Brian Dean, http://www.bdmicro.com/
                  Copyright (c) 2007-2014 Joerg Wunsch

                  System wide configuration file is "/etc/avrdude.conf"
                  User configuration file is "/root/.avrduderc"
                  User configuration file does not exist or is not a regular file, skipping

                  Using Port                    : /dev/ttyAMA0
                  Using Programmer              : arduino
                  Overriding Baud Rate          : 115200
avrdude-original: Using autoreset DTR on GPIO Pin 7
                  AVR Part                      : ATmega328P
                  Chip Erase delay              : 9000 us
                  PAGEL                         : PD7
                  BS2                           : PC2
                  RESET disposition             : dedicated
                  RETRY pulse                   : SCK
                  serial program mode           : yes
                  parallel program mode         : yes
                  Timeout                       : 200
                  StabDelay                     : 100
                  CmdexeDelay                   : 25
                  SyncLoops                     : 32
                  ByteDelay                     : 0
                  PollIndex                     : 3
                  PollValue                     : 0x53
                  Memory Detail                 :

                                           Block Poll               Page                       Polled
                    Memory Type Mode Delay Size  Indx Paged  Size   Size #Pages MinW  MaxW   ReadBack
                    ----------- ---- ----- ----- ---- ------ ------ ---- ------ ----- ----- ---------
                    eeprom        65    20     4    0 no       1024    4      0  3600  3600 0xff 0xff
                    flash         65     6   128    0 yes     32768  128    256  4500  4500 0xff 0xff
                    lfuse          0     0     0    0 no          1    0      0  4500  4500 0x00 0x00
                    hfuse          0     0     0    0 no          1    0      0  4500  4500 0x00 0x00
                    efuse          0     0     0    0 no          1    0      0  4500  4500 0x00 0x00
                    lock           0     0     0    0 no          1    0      0  4500  4500 0x00 0x00
                    calibration    0     0     0    0 no          1    0      0     0     0 0x00 0x00
                    signature      0     0     0    0 no          3    0      0     0     0 0x00 0x00

                  Programmer Type : Arduino
                  Description     : Arduino
                  Hardware Version: 3
                  Firmware Version: 4.4
                  Vtarget         : 0.3 V
                  Varef           : 0.3 V
                  Oscillator      : 28.800 kHz
                  SCK period      : 3.3 us

avrdude-original: AVR device initialized and ready to accept instructions

Reading | ################################################## | 100% 0.00s

avrdude-original: Device signature = 0x1e950f (probably m328p)
avrdude-original: safemode: lfuse reads as 0
avrdude-original: safemode: hfuse reads as 0
avrdude-original: safemode: efuse reads as 0
avrdude-original: NOTE: "flash" memory has been specified, an erase cycle will be performed
                  To disable this feature, specify the -D option.
avrdude-original: erasing chip
avrdude-original: reading input file "firmware.hex"
avrdude-original: input file firmware.hex auto detected as Intel Hex
avrdude-original: writing flash (19012 bytes):

Writing | ################################################## | 100% 2.72s

avrdude-original: 19012 bytes of flash written
avrdude-original: verifying flash memory against firmware.hex:
avrdude-original: load data flash data from input file firmware.hex:
avrdude-original: input file firmware.hex auto detected as Intel Hex
avrdude-original: input file firmware.hex contains 19012 bytes
avrdude-original: reading on-chip flash data:

Reading | ################################################## | 100% 2.04s

avrdude-original: verifying ...
avrdude-original: 19012 bytes of flash verified

avrdude-original: safemode: lfuse reads as 0
avrdude-original: safemode: hfuse reads as 0
avrdude-original: safemode: efuse reads as 0
avrdude-original: safemode: Fuses OK (E:00, H:00, L:00)
strace: |autoreset: Broken pipe
strace: |autoreset: Broken pipe
strace: |autoreset: Broken pipe
strace: |autoreset: Broken pipe
strace: |autoreset: Broken pipe

avrdude-original done.  Thank you.

strace: |autoreset: Broken pipe

```

when I monitor, I have to specify the baudrate :
```
pio device monitor -b 38400
--- Available filters and text transformations: colorize, debug, default, direct, hexlify, log2file, nocontrol, printable, send_on_enter, time
--- More details at http://bit.ly/pio-monitor-filters

--- Available ports:
---  1: /dev/ttyAMA0         'ttyAMA0'
--- Enter port index or full name: 1
--- Miniterm on /dev/ttyAMA0  38400,8,N,1 ---
--- Quit: Ctrl+C | Menu: Ctrl+T | Help: Ctrl+T followed by Ctrl+H ---
OK 5 245 255 0 0 245 255 183 93 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 (-0)
OK 5 248 255 0 0 248 255 192 93 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 (-0)
OK 5 248 255 0 0 248 255 32 94 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 (-0)
OK 5 248 255 0 0 248 255 1 94 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 (-0)
OK 5 250 255 0 0 250 255 70 94 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 (-0)
OK 5 250 255 0 0 250 255 127 94 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 (-0)
OK 5 239 255 0 0 239 255 163 94 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 (-0)

--- exit ---
```

# EmonTxV3CM plus PlatformIO within Atom on a ubuntu 18.04 machine

## the bad way : 

goal : insert new calibration values

- modify the config.ino with my Vcal value > line 112 `vCal         = 246.18;//data.vCal;`
- lauch a platformIO terminal
- run `pio run -t upload`, which creates a .pio/build/emontx directory with a firmware.hex file and upload the firmware
- reboot the emonTx

To manually upload firmware.hex on the emonTx :
```
cd .pio/build/emontx
avrdude -v -c arduino -p ATMEGA32 8P -P /dev/ttyUSB0 -b 115200 -U flash:w:firmware.hex
```
## the good way

do not modify the config.ino

keep `vCal         = data.vCal;`

Use the trick to calibrate during the measurement process itself with the command : `k0 246.2`

This is very convenient both with PlatformIO and with the arduino IDE
![](PIO_send_command.png)
![](PIO_saving.png)

type `l` during the measurement if you want to check the settings

what is missing is how to calibrate in intensity.
First you have to modify the firmware in order to track current values
