using PlatformIO within Atom on a ubuntu 18.04 machine, I had to do the following : 

- modify the config.ino with my Vcal value > line 112 `vCal         = 246.18;//data.vCal;`
- lauch a platformIO terminal
- run `pio run -t upload`, which creates a .pio/build/emontx directory with a firmware.hex file
- upload the firmware.hex on the emonTx : `cd .pio/build/emontx` followed by `vrdude -v -c arduino -p ATMEGA32
8P -P /dev/ttyUSB0 -b 115200 -U flash:w:firmware.hex`
- reboot the emonTx

then the new calibration values are taken into account

But there is a way to calibrate during the measurement process itself with the command : `k0 246.2`

This is very convenient both with PlatformIO and with the arduino IDE
![](PIO_send_command.png)

what is missing is how to calibrate in intensity.
First you have to modify the firmware in order to track current values
