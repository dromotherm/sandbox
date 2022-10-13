Avec le même bus comportant un seul matériel promux d'id 2

juste après l'install :

```
python3 promuxDiscovery.py 
mode : rtu ou tcp ? [rtu]: 
{'success': True, 'text': 'modbus RTU connexion opened port /dev/ttyUSB0 - 9600 bauds'}
unit 0 inexistant
unit 1 inexistant
*****************************
unit 2
software version 7
module number 109
module type PM6RTD
Traceback (most recent call last):
  File "/home/alexandrecuer/Documents/GitHub/BIOS2/hardware/promuxDiscovery.py", line 246, in <module>
    discover()
  File "/usr/lib/python3/dist-packages/click/core.py", line 1128, in __call__
    return self.main(*args, **kwargs)
  File "/usr/lib/python3/dist-packages/click/core.py", line 1053, in main
    rv = self.invoke(ctx)
  File "/usr/lib/python3/dist-packages/click/core.py", line 1395, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/lib/python3/dist-packages/click/core.py", line 754, in invoke
    return __callback(*args, **kwargs)
  File "/home/alexandrecuer/Documents/GitHub/BIOS2/hardware/promuxDiscovery.py", line 215, in discover
    a = modbusCon.read_holding_registers(99,1,slave=unitId).registers
AttributeError: 'ModbusIOException' object has no attribute 'registers'
```

plus tard :

```
python3 promuxDiscovery.py 
mode : rtu ou tcp ? [rtu]: 
{'success': True, 'text': 'modbus RTU connexion opened port /dev/ttyUSB0 - 9600 bauds'}
unit 0 inexistant
unit 1 inexistant
unit 2 inexistant
unit 3 inexistant
unit 4 inexistant
unit 5 inexistant
unit 6 inexistant
unit 7 inexistant
^C
Aborted!
```

enfin

```
ython3 promuxDiscovery.py 
mode : rtu ou tcp ? [rtu]: 
{'success': True, 'text': 'modbus RTU connexion opened port /dev/ttyUSB0 - 9600 bauds'}
unit 0 inexistant
unit 1 inexistant
*****************************
unit 2
software version 7
module number 109
module type PM6RTD
modbus address 2
baudrate 1 parity 0 stopbits 1 replydelay 0
lecture des DI
False True True False True False True True 
lecture des DO
False False False True True False True True 
lecture des compteurs
14221526 2147516416 83886080 0 6422628 6553600 3028484096 0 
*****************************
^C
Aborted!
```
