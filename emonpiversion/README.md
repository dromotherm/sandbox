```
cd /boot
sudo touch emonSD-themisv0
sudo rm emonSD-02Oct19 
sudo systemctl restart emonPiLCD
```
nota : safe update via le module amdin ne fonctionnera plus vu que cette image n'est pas reconnue

```
cd /opt/openenergymonitor/EmonScripts/
nano safe-update
```

```
emonSD-themisv0
emonSD-24Jul20
emonSD-02Oct19
emonSD-17Oct19
```



