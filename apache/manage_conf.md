# create a new alias
```
cd /etc/apache2/sites-available
sudo touch 000-default.conf.conf
```
on rajoute les lignes suivantes :
```
Alias /obm  /home/alexandrecuer/github/Open-Building-Management.github.io/
<Directory /home/alexandrecuer/github/Open-Building-Management.github.io/>
  Options Indexes FollowSymLinks
  AllowOverride None
  Require all granted
</Directory>
```
