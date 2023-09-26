
# systemd

https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs

https://github.com/systemd/systemd/blob/main/docs/UIDS-GIDS.md

**If your run a python script as a service, it is good to have a little knowledge on systemd**

pour du détail sur les processus démarrant en toile de fond : `sudo dmesg`

cf https://fr.wikipedia.org/wiki/Dmesg


## easy log from python to journald

https://stackoverflow.com/questions/34588421/how-to-log-to-journald-systemd-via-python

How to allow a user to use journalctl to see user-specific systemd service logs ? 
https://lists.freedesktop.org/archives/systemd-devel/2016-October/037554.html

on utilise la commande `journalctl -u nom_service` en ajax 

cf https://github.com/alexjunk/OBMmonitor/blob/main/OBMmonitor_controller.php#L95

et il faut que l'user www-data ait les bonnes permissions

cf https://github.com/alexjunk/BIOS2/blob/pymodbus3/raspberry/requires.sh


## basic usage

Vérifier l'état des services, gérés par systemd

```
systemctl status
systemctl status bios
journalctl -u bios
sudo systemctl daemon-reload
```

## timers
```
systemctl list-timers
NEXT                        LEFT          LAST                        PASSED     UNIT                         ACTIVATES
Sat 2023-01-07 20:39:00 CET 24min left    Sat 2023-01-07 20:09:20 CET 5min ago   phpsessionclean.timer        phpsessionclean.service
Sun 2023-01-08 00:00:00 CET 3h 45min left Sat 2023-01-07 00:00:20 CET 20h ago    logrotate.timer              logrotate.service
Sun 2023-01-08 00:00:00 CET 3h 45min left Sat 2023-01-07 00:00:20 CET 20h ago    man-db.timer                 man-db.service
Sun 2023-01-08 00:35:44 CET 4h 21min left Sat 2023-01-07 10:01:20 CET 10h ago    apt-daily.timer              apt-daily.service
Sun 2023-01-08 03:10:46 CET 6h left       Sun 2023-01-01 03:10:33 CET 6 days ago e2scrub_all.timer            e2scrub_all.service
Sun 2023-01-08 06:23:26 CET 10h left      Sat 2023-01-07 06:26:55 CET 13h ago    apt-daily-upgrade.timer      apt-daily-upgrade.service
Sun 2023-01-08 08:28:28 CET 12h left      Sat 2023-01-07 08:28:28 CET 11h ago    systemd-tmpfiles-clean.timer systemd-tmpfiles-clean.service
Mon 2023-01-09 00:37:48 CET 1 day 4h left Mon 2023-01-02 00:51:04 CET 5 days ago fstrim.timer                 fstrim.service
```

## queued jobs 
```
systemctl list-jobs
```

## check which version of systemd is installed
```
pkg-config --modversion systemd
237
```
other option :
```
pkg-config --exists systemd && echo $?
```
should return 0 if systemd is installed

alternative with readlink
```
sudo readlink -f /proc/1/exe
```
should return `/lib/systemd/systemd`

### for more on pkg-config :

https://www.freedesktop.org/wiki/Software/pkg-config/

https://people.freedesktop.org/~dbn/pkg-config-guide.html

## finding the user running a systemd service

in the makefile
```
service-runner := service-runner.service
service-runner-user := $(shell systemctl show $(service-runner)|grep --perl-regexp -o '(?<=(^User=))([a-zA-Z0-9]*)')

@echo "service-runner is run by "$(service-runner-user)
@sudo touch $(log_dir)/restart.log
@sudo chown $(service-runner-user) $(log_dir)/restart.log
```
Then in PHP :

```
$cmd = "sudo systemctl restart bios.service>/var/log/bios/restart.log";
$redis->rpush("service-runner",$cmd);
```      
