#!/bin/bash

# interrogates the shebang of emonPiLCD.py to catch the python version
shebang="$(head -1 emonPiLCD.py)"
splitted=($(echo $shebang | tr "/" "\n"))
python="${splitted[-1]}"

sudo apt update

if [ "$python" = "python3" ]; then
    sudo apt-get install python3-smbus i2c-tools python3-rpi.gpio python3-pip redis-server  python3-gpiozero -y
    pip3 install redis paho-mqtt xmltodict requests
else
    sudo apt-get install -y python-smbus i2c-tools python-rpi.gpio python-gpiozero
    pip install redis paho-mqtt xmltodict requests
fi
