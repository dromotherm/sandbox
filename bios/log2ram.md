bios utilise log2ram pour le management des fichiers log en ram

bios est sur une architecture emonpi sur laquelle c'est log2ram qui lance logrotate toutes les heures (tache /etc/cron.hourly) 
```
ls -al /etc/cron*
-rw-r--r-- 1 root root 1042 Feb 22  2021 /etc/crontab

/etc/cron.d:
total 20
drwxr-xr-x  2 root root 4096 Jan 11  2022 .
drwxr-xr-x 87 root root 4096 Oct 13 18:42 ..
-rw-r--r--  1 root root  204 Jun  7  2021 e2scrub_all
-rw-r--r--  1 root root  712 May 11  2020 php
-rw-r--r--  1 root root  102 Feb 22  2021 .placeholder

/etc/cron.daily:
total 32
drwxr-xr-x  2 root root 4096 Jan 11  2022 .
drwxr-xr-x 87 root root 4096 Oct 13 18:42 ..
-rwxr-xr-x  1 root root  539 Aug  8  2020 apache2
-rwxr-xr-x  1 root root 1478 Jun 10  2021 apt-compat
-rwxr-xr-x  1 root root 1298 Apr 30  2021 dpkg
-rwxr-xr-x  1 root root  160 Jan 11  2022 logrotate
-rwxr-xr-x  1 root root 1123 Feb 19  2021 man-db
-rw-r--r--  1 root root  102 Feb 22  2021 .placeholder

/etc/cron.hourly:
total 16
drwxr-xr-x  2 root root 4096 Jan 11  2022 .
drwxr-xr-x 87 root root 4096 Oct 13 18:42 ..
-rwxr-xr-x  1 root root  191 Feb 22  2012 fake-hwclock
lrwxrwxrwx  1 root root   35 Jan 11  2022 log2ram -> /opt/openenergymonitor/cron/log2ram
-rw-r--r--  1 root root  102 Feb 22  2021 .placeholder

/etc/cron.monthly:
total 12
drwxr-xr-x  2 root root 4096 Oct 30  2021 .
drwxr-xr-x 87 root root 4096 Oct 13 18:42 ..
-rw-r--r--  1 root root  102 Feb 22  2021 .placeholder

/etc/cron.weekly:
total 16
drwxr-xr-x  2 root root 4096 Oct 30  2021 .
drwxr-xr-x 87 root root 4096 Oct 13 18:42 ..
-rwxr-xr-x  1 root root  813 Feb 19  2021 man-db
-rw-r--r--  1 root root  102 Feb 22  2021 .placeholder
```

pour voir les derniers évènements relatifs à log2ram dans le syslog
```
grep log2ram /var/log/syslog
```
on a crée un fichier de rotation pour bios :

```
/var/log/bios/*.log {
        hourly
        missingok
        rotate 7
        compress
        notifempty
        size 3M
}
```
pour le mettre en place :

```
sudo ln -sf /opt/openenergymonitor/bios /etc/logrotate.d/bios
```

# log2ram ne veut pas démarrer

## cas 1

cf https://github.com/azlux/log2ram/issues/90

```
 systemctl status log2ram
● log2ram.service - Log2Ram
     Loaded: loaded (/etc/systemd/system/log2ram.service; enabled; vendor prese>
     Active: failed (Result: exit-code) since Tue 2022-06-07 23:24:04 CEST; 34s>
    Process: 1033 ExecStart=/usr/local/bin/log2ram start (code=exited, status=1>
   Main PID: 1033 (code=exited, status=1/FAILURE)
        CPU: 67ms

Jun 07 23:24:04 emonpi systemd[1]: Starting Log2Ram...
Jun 07 23:24:04 emonpi log2ram[1033]: ERROR: RAM disk too small. Can't sync.
Jun 07 23:24:04 emonpi log2ram[1045]: /usr/local/bin/log2ram: 39: mail: not fou>
Jun 07 23:24:04 emonpi systemd[1]: log2ram.service: Main process exited, code=e>
Jun 07 23:24:04 emonpi systemd[1]: log2ram.service: Failed with result 'exit-co>
Jun 07 23:24:04 emonpi systemd[1]: Failed to start Log2Ram.
```
On vérifie l'espace occupé par /var/log :
```
sudo du -sh /var/log
66M	/var/log
```
et on augmente SIZE en conséquence dans /etc/log2ram.conf


## cas 2

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
# /var/log se remplit

pour trouver les gros fichiers dans /var/log

```
sudo du -a /var/log/* | sort -n -r | head -n 30
49164	/var/log/journal/428e68fb775e41d5904f1a673b4211e2
49164	/var/log/journal
8192	/var/log/journal/428e68fb775e41d5904f1a673b4211e2/user-1000.journal
8192	/var/log/journal/428e68fb775e41d5904f1a673b4211e2/system@11cce4966f6747cf8aeb231cc28a2896-0000000000000001-0005cf90427acc19.journal
8192	/var/log/journal/428e68fb775e41d5904f1a673b4211e2/system@0005d44b9acc97bc-3ed8f1327077645d.journal~
8192	/var/log/journal/428e68fb775e41d5904f1a673b4211e2/system@0005d44b566939bb-dfdc48ff51e41e46.journal~
8192	/var/log/journal/428e68fb775e41d5904f1a673b4211e2/system@0005d4490dfd4d2f-de42b97e8cc493df.journal~
8192	/var/log/journal/428e68fb775e41d5904f1a673b4211e2/system@0005d4474744033e-a0e6852ad4d5e075.journal~
512	/var/log/syslog
288	/var/log/lastlog
252	/var/log/kern.log
248	/var/log/daemon.log
232	/var/log/messages
164	/var/log/apt
128	/var/log/apt/term.log
104	/var/log/dpkg.log
52	/var/log/auth.log
24	/var/log/debug
24	/var/log/apt/eipp.log.xz
20	/var/log/wtmp
16	/var/log/redis/redis-server.log
16	/var/log/redis
16	/var/log/emoncms
12	/var/log/emoncms/apache2-error.log
12	/var/log/apt/history.log
8	/var/log/alternatives.log
4	/var/log/user.log
4	/var/log/mosquitto/mosquitto.log
4	/var/log/mosquitto
4	/var/log/log2ram.log
```
si la rotation des log ne fonctionne pas
```
sudo truncate -s 0 /var/log/logrotate/logrotate.log
```
