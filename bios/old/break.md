# si on n'installe pas les dépendances
```
./bios.py 
Traceback (most recent call last):
  File "/opt/openenergymonitor/BIOS2/./bios.py", line 10, in <module>
    from pilot import pilot, threading
  File "/opt/openenergymonitor/BIOS2/pilot.py", line 5, in <module>
    from planning import tsToHuman, getContext, biosAgenda, getLevelDuration
  File "/opt/openenergymonitor/BIOS2/planning.py", line 1, in <module>
    import numpy as np
ModuleNotFoundError: No module named 'numpy'
```

# si on installe les dépendances mais pas tensorflow

```
./bios.py 
2022-01-12 16:14:43,620 INFO     MainThread ............OUVERTURE DU nrjManager BIOS............
2022-01-12 16:14:43,620 DEBUG    MainThread No module named 'tensorflow' - No module named 'tflite_runtime'
2022-01-12 16:14:43,620 DEBUG    MainThread wiringpi bien installé !
2022-01-12 16:14:43,974 DEBUG    MainThread Connected to MySQL Server version 5.5.5-10.5.12-MariaDB-0+deb11u1 - feeding redis :-)
2022-01-12 16:14:43,976 INFO     MainThread Initialisation de l'agent test1
2022-01-12 16:14:43,978 INFO     test1      start:2022-01-12 16:00:00:+0000 - step:1800 s
2022-01-12 16:14:43,985 INFO     compile    datas aggregator activated
2022-01-12 16:14:43,997 INFO     cleaner    start:2022-01-12 16:00:00:+0000 step:1800 s
2022-01-12 16:14:44,003 DEBUG    cleaner    checking for volatile feeds to be deleted
2022-01-12 16:14:44,009 INFO     snifferOWMh planning : 2022-01-12 10:00:00:+0000
2022-01-12 16:14:44,016 INFO     snifferOWMd planning : 2022-01-12 06:00:00:+0000
2022-01-12 16:14:44,022 INFO     snifferOWMh planning : 2022-01-12 22:00:00:+0000
2022-01-12 16:14:44,030 INFO     test1      Activité humaine en cours pendant 2 steps
2022-01-12 16:14:44,031 INFO     snifferOWMd start:2022-01-12 16:00:00:+0000 step:3600 s
2022-01-12 16:14:44,031 INFO     snifferOWMh start:2022-01-12 16:00:00:+0000 step:3600 s
2022-01-12 16:14:44,033 DEBUG    snifferOWMd no daily forecasts yet - need to populate
2022-01-12 16:14:44,035 DEBUG    snifferOWMh no hourly forecasts yet - need to populate
2022-01-12 16:14:44,047 DEBUG    snifferOWMh Connected to MySQL Server version 5.5.5-10.5.12-MariaDB-0+deb11u1 - feeding redis :-)
2022-01-12 16:14:44,051 DEBUG    snifferOWMd Connected to MySQL Server version 5.5.5-10.5.12-MariaDB-0+deb11u1 - feeding redis :-)
2022-01-12 16:14:44,748 INFO     snifferOWMh sniffing OWM API
2022-01-12 16:14:44,749 DEBUG    snifferOWMh https://api.openweathermap.org/data/2.5/onecall?lat=45.8&lon=3.125&exclude=current,minutely,daily&appid=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx&units=metric
2022-01-12 16:14:44,762 INFO     snifferOWMd sniffing OWM API
2022-01-12 16:14:44,762 DEBUG    snifferOWMd https://api.openweathermap.org/data/2.5/onecall?lat=45.8&lon=3.125&exclude=current,minutely,hourly&appid=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx&units=metric
2022-01-12 16:14:47,029 DEBUG    compile    génération des prévisions de référence...
2022-01-12 16:14:48,965 DEBUG    compile    mise à jour de la prédiction de référence
2022-01-12 16:14:48,965 DEBUG    compile    TEMP as a EMONCMS object : success
2022-01-12 16:14:50,966 DEBUG    compile    SUN as a EMONCMS object : success
^C2022-01-12 16:15:27,788 DEBUG    MainThread signal de fermeture reçu
2022-01-12 16:15:27,960 INFO     MainThread BIOS : 7 threads en cours d'exécution
2022-01-12 16:15:27,961 INFO     MainThread mqtt va être fermé
2022-01-12 16:15:28,059 INFO     MainThread test1 va être fermé
2022-01-12 16:15:28,126 INFO     MainThread compile va être fermé
2022-01-12 16:15:28,167 INFO     MainThread cleaner va être fermé
2022-01-12 16:15:28,206 INFO     MainThread snifferOWMh va être fermé
2022-01-12 16:15:28,242 INFO     MainThread snifferOWMd va être fermé
2022-01-12 16:15:28,260 INFO     MainThread BIOS est à l'arrêt
```
nota : comme on a aucun flux dans cet exemple, bios veut toujours remplir redis
