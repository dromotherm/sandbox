# accéder à redis depuis un autre pi en local

sur la machine qui utilise redis comme datalake, dont on suppose que l'adresse ip locale est 192.168.2.2

```
sudo nano /etc/redis/redis.conf
```

on remplace la ligne :
```
bind 127.0.0.1 ::1
```

par :
```
bind 192.168.2.2 127.0.0.1 ::1
```
pour obtenir la dernière valeur du flux 1 depuis un autre pi, on utilise la script suivant :

```
import redis
r = redis.Redis(host="192.168.2.2", port=6379, db=0)
a = r.hgetall("feed:1")
print(a["value"])
```
