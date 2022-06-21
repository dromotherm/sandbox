## systemd

**If your run a python script as a service, it is good to have a little knowledge on systemd**

pour du détail sur les processus démarrant en toile de fond : `sudo dmesg`

cf https://fr.wikipedia.org/wiki/Dmesg

### basic usage

Vérifier l'état des services, gérés par systemd

```
systemctl status
systemctl status bios
journalctl -f -u bios
sudo systemctl daemon-reload
```

### check which version of systemd is installed
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

#### for more on pkg-config :

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
