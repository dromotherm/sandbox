# Slightly modified firmwares

P : puissance en W

I : 100 * intensité RMS (root mean square) en A

F : 100 * facteur de puissance

V : 100 * tension en V

T : 10 * temperature en °C

## emontx quadriphase

https://github.com/alexandrecuer/emontx-3phase

0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20
--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--
what ? | P1 | P2 | P3 | P4 | V | I1 | I2 | I3 | I4 | F1 | F2 | F3 | F4 | T1 | T2 | T3 | T4 | T5 | T6 | pulse
datacodes|h|h|h|h|h|h|h|h|h|h|h|h|h|h|h|h|h|h|h|L
scales|1|1|1|1|0.01|0.01|0.01|0.01|0.01|0.01|0.01|0.01|0.01|0.1|0.1|0.1|0.1|0.1|0.1|1

![image](https://github.com/dromotherm/sandbox/assets/24553739/e135544b-1822-4442-9ddd-0cb5ea4da389)

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
