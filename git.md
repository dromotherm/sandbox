change the uri/url fo a remote git repository `git remote set-url origin https://github.com/alexandrecuer/emoncms`

see which remote URL you have currently in this local repository: `git remote show origin`

count number of code lines `git ls-files | grep -P ".*(py)" | xargs wc -l`

https://panjeh.medium.com/github-git-tag-release-to-an-old-commit-8fe38ee7167f

pour chercher un pattern dans le code : `git grep pattern`

pour voir les différences : `git diff`

undo last commit not pushed : `git reset --soft HEAD~`

This command undoes the latest commit, keeps the changes in place, and reverts the files back to the staging area.

# permissions problems

maybe this happens if one time you run git as sudo

```
git fetch
Username for 'https://github.com': alexandrecuer
Password for 'https://alexandrecuer@github.com': 
warning: redirecting to https://github.com/alexjunk/BIOS2/
remote: Enumerating objects: 39, done.
remote: Counting objects: 100% (39/39), done.
remote: Compressing objects: 100% (23/23), done.
remote: Total 39 (delta 17), reused 34 (delta 15), pack-reused 0 (from 0)
error: insufficient permission for adding an object to repository database .git/objects
fatal: failed to write object
fatal: unpack-objects failed
```
the solution is to fix permissions manually in the .git folder
```
cd .git/objects
ls -al
sudo chown -R yourname:yourgroup *
```

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

