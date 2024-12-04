# PIO

https://docs.openenergymonitor.org/emontx3/firmware.html

https://docs.platformio.org/en/latest/core/installation/methods/index.html

install venv if needed
```
sudo apt-get install python3.10-venv
```
then
```
curl -fsSL -o get-platformio.py https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py
```
Add pio path in path :
```
nano .bashrc
export PATH="/home/alexandrecuer/.platformio/penv/bin:$PATH"
git clone https://github.com/alexandrecuer/emontx3
cd emontx3/firmware
```
connect the emontx to the computer with a usb cable :
```
sudo chmod a+rw /dev/ttyUSB0
pio run -t upload
```
to monitor (emontx5 running at 115200)
```
pio device monitor -p /dev/ttyUSB0 -b 115200 --filter send_on_enter --echo
```
https://docs.platformio.org/en/latest/core/userguide/device/cmd_monitor.html#cmd-device-monitor-filters


# Slightly modified firmwares

P : puissance en W

I : 100 * intensité RMS (root mean square) en A

F : 100 * facteur de puissance

V : 100 * tension en V

T : 10 * temperature en °C

## emontx triphase

pour mémoire, à l'entpe, les 3 phases avaient les couleurs suivantes : rouge, noir et marron

dans le sketch, WIRES a la valeur 4-WIRE

4-WIRE = default, measure voltage L1 - N

3-WIRE = no neutral, measure voltage L1 - L2

https://github.com/alexandrecuer/emontx-3phase

0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20
--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--
what ? | P1 | P2 | P3 | P4 | V | I1 | I2 | I3 | I4 | F1 | F2 | F3 | F4 | T1 | T2 | T3 | T4 | T5 | T6 | pulse
datacodes|h|h|h|h|h|h|h|h|h|h|h|h|h|h|h|h|h|h|h|L
scales|1|1|1|1|0.01|0.01|0.01|0.01|0.01|0.01|0.01|0.01|0.01|0.1|0.1|0.1|0.1|0.1|0.1|1

Le système mesure une seule tension, celle de la phase 1 et recrée artificiellement les tensions des phases 2 et 3. Il faut donc au départ tatonner pour trouver la phase associée à la tension que l'on a décidé de mesurer et c'est le facteur de puissance qui nous guide.

Le système mesure en temps réel les intensités sur chacune des phases, puis calcule les puissances réelles et apparentes et en déduit les facteurs de puissance respectifs.

Par exemple, pour des pompes, le facteur de puissance est de 0.8 ou 0.9

La puissance totale est la somme des 3 puissances mesurées

## emontx monophase

https://github.com/alexandrecuer/emontx3

0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20
--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--
what ? | P1 | P2 | P3 | P4 | I1 | I2 | I3 | I4 | F1 | F2 | F3 | F4 | V | T1 | T2 | T3 | T4 | T5 | T6 | pulse
datacodes|h|h|h|h|h|h|h|h|h|h|h|h|h|h|h|h|h|h|h|L
scales|1|1|1|1|0.01|0.01|0.01|0.01|0.01|0.01|0.01|0.01|0.01|0.1|0.1|0.1|0.1|0.1|0.1|1

# to run a sniffer on emonpi first gen

```
sudo docker run --rm --network=bios2_default --device=/dev/ttyAMA0 -it -e MQTT_HOST=themis alexjunk/emontx_sniffer:alpine3.18.1
```

# to read on the OEM forum

https://community.openenergymonitor.org/t/whats-happened-to-emontx-v4/25775/6
