# recherches pour faire fonctionner les drivers CH341

juste pour la culture générale

remove nvgetty

https://github.com/JetsonHacksNano/UARTDemo/blob/master/README.md


CONFIG_USB_SERIAL_CH341 must be set in /proc/config.gz

```
sudo apt remove brltty
```

des répertoires avec des sources de drivers CH341 modifiées

https://github.com/juliagoda/CH341SER

https://github.com/aperepel/raspberrypi-ch340-driver

https://github.com/skyrocknroll/CH341SER_LINUX
