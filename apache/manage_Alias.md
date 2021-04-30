# Gestion des alias

# Prérequis
Si on veut créer un alias Apache pour un répertoire, il faut qu'il dispose des permissions adaptées 

```
cd flot-4.2.2
chmod 755 source
chmod 755 lib
chmod 755 $(find examples -type d)
```
La dernière ligne sert à appliquer les permissions au répertoire examples et à tous les sous-répertoires qu'il contient, sans affecter les fichiers

# Création

```
cd /etc/apache2/sites-available
sudo nano 000-default.conf
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



