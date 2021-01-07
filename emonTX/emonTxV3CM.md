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
