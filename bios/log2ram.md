```
sudo systemctl status log2ram
● log2ram.service - Log2Ram
     Loaded: loaded (/etc/systemd/system/log2ram.service; enabled; vendor preset: enabled)
     Active: failed (Result: exit-code) since Wed 2021-12-29 17:58:52 CET; 40s ago
    Process: 292 ExecStart=/usr/local/bin/log2ram start (code=exited, status=1/FAILURE)
   Main PID: 292 (code=exited, status=1/FAILURE)
        CPU: 2.201s

Dec 29 17:58:52 emonpi log2ram[342]: mosquitto/mosquitto.log
Dec 29 17:58:52 emonpi log2ram[342]: mysql/
Dec 29 17:58:52 emonpi log2ram[342]: private/
Dec 29 17:58:52 emonpi log2ram[342]: redis/
Dec 29 17:58:52 emonpi log2ram[342]: redis/redis-server.log
Dec 29 17:58:52 emonpi log2ram[342]: runit/
Dec 29 17:58:52 emonpi log2ram[342]: runit/ssh/
Dec 29 17:58:52 emonpi log2ram[342]: sent 51,966,246 bytes  received 694 bytes  34,644,626.67 bytes/sec
Dec 29 17:58:52 emonpi log2ram[342]: total size is 51,950,486  speedup is 1.00
Dec 29 17:58:52 emonpi log2ram[384]: ln: failed to create symbolic link '/var/log/rotated_logs': File exists
```
on supprime :
```
pi@emonpi:~ $ sudo rm -Rf /var/log/rotated_logs
pi@emonpi:~ $ sudo systemctl restart log2ram
pi@emonpi:~ $ sudo systemctl status log2ram
● log2ram.service - Log2Ram
     Loaded: loaded (/etc/systemd/system/log2ram.service; enabled; vendor preset: enabled)
     Active: active (exited) since Wed 2021-12-29 18:00:29 CET; 2s ago
    Process: 824 ExecStart=/usr/local/bin/log2ram start (code=exited, status=0/SUCCESS)
   Main PID: 824 (code=exited, status=0/SUCCESS)
        CPU: 1.129s

Dec 29 18:00:29 emonpi log2ram[834]: mosquitto/mosquitto.log
Dec 29 18:00:29 emonpi log2ram[834]: mysql/
Dec 29 18:00:29 emonpi log2ram[834]: private/
Dec 29 18:00:29 emonpi log2ram[834]: redis/
Dec 29 18:00:29 emonpi log2ram[834]: redis/redis-server.log
Dec 29 18:00:29 emonpi log2ram[834]: runit/
Dec 29 18:00:29 emonpi log2ram[834]: runit/ssh/
Dec 29 18:00:29 emonpi log2ram[834]: sent 52,119,800 bytes  received 710 bytes  34,747,006.67 bytes/sec
Dec 29 18:00:29 emonpi log2ram[834]: total size is 52,103,163  speedup is 1.00
Dec 29 18:00:29 emonpi systemd[1]: Finished Log2Ram.
```
