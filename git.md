count number of code lines `git ls-files | grep -P ".*(py)" | xargs wc -l`

https://panjeh.medium.com/github-git-tag-release-to-an-old-commit-8fe38ee7167f

pour chercher un pattern dans le code : `git grep pattern`

pour voir les différences : `git diff`

undo last commit not pushed : `git reset --soft HEAD~`

This command undoes the latest commit, keeps the changes in place, and reverts the files back to the staging area.

# emoncms bios version

on peut choisir une branche bios_master, bios_stable
```
git config --list
git remote set-url origin https://github.com/alexandrecuer/emoncms.git
git pull
git branch -a
git checkout bios_master
```
on installe OBMmonitor
```
cd /var/www/emoncms/Modules
git clone https://github.com/alexjunk/OBMmonitor
```

Tous les service files relatifs à BIOS sont dans /etc/systemd/system

service | exe | conf | log
--|--|--|--
bios | /usr/local/bin/bios | /etc/bios/bios.conf| /var/log/bios/bios.log
ota2, modbus, rpihwm, ihm| /usr/local/bin/bios_hardware| /etc/bios|/var/log/bios

Si le service s'appelle aaa, le log est aaa.log et le conf aaa.conf, si un conf est utilisé 

