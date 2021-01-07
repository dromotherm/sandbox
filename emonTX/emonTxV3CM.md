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
so I did only compilation then upload with avrdude:
```
pio run
cd .pio/build/emonpi
avrdude -v -c arduino -p ATMEGA328P -P /dev/ttyAMA0 -b 115200 -U flash:w:firmware.hex
```
The answer should include the following :
```
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

```
I did not bothered about `strace: |autoreset: Broken pipe` lines in the return....

then restart emonhub so that the changes are taken into account :
```
sudo systemctl stop emonhub
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
OK 5 245 255 0 0 245 255 168 88 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 (-0)
OK 5 248 255 0 0 248 255 55 89 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 (-0)
```
to recalculate, cf emonhub :

```
2021-01-07 10:53:33,049 DEBUG    RFM2Pi     248 NEW FRAME : OK 5 250 255 0 0 250 255 170 88 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 (-0)
2021-01-07 10:53:33,050 DEBUG    RFM2Pi     248 Timestamp : 1610013213.04941
2021-01-07 10:53:33,051 DEBUG    RFM2Pi     248 From Node : 5
2021-01-07 10:53:33,051 DEBUG    RFM2Pi     248    Values : [-6, 0, -6, 226.98000000000002, 0, 0, 0, 0, 0, 0, 0]
```
170 decimal is AA hexa
88 decimal is 58 hexa
as we are in little endian, the resulting voltage is 58AA hex, or 22698 decimal, which is 226.98 with a 0.01 scale


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
