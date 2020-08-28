# Finalisation d'une SD pour production d'une carte Themis
```
cd /boot
sudo touch emonSD-themisv0
sudo rm emonSD-02Oct19 
sudo systemctl restart emonPiLCD
```
nota : safe update via le module admin ne fonctionnera plus vu que cette image n'est pas reconnue
Pour contourner, on peut faire la séquence suivante...

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

```
cd /opt/openenergymonitor/EmonScripts/update
nano service-runner-update.sh
```
on remplace le wget qui va chercher le safe-update sur un github par un cat

```
    while [ $retry -lt 5 ]; do
        safe_to_update=$(cat ../safe-update)
        if [ "$safe_to_update" == "" ]; then
            echo "  retry fetching safe-update list"
            retry=$((retry+1))        
            sleep 3
        else
            break
        fi

```
Mais dans un premier temps, il vaut mieux ne pas avoir ces updates automatiques.....





