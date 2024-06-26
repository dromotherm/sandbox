# serveur flask servant des containers emoncms

Le serveur d'applications permet à un utilisateur qui veut tester emoncms de tirer un numéro de port entre 8080 et 9090 et de lancer un container.

Pour faire simple, la machine hôte tourne sous ubuntu, avec systemd. 

Dans une distribution ubuntu, les fichiers de configuration du serveur apache sont dans `/etc/apache2` et le fichier principal est `apache2.conf`. `/etc/apache2` contient 2 sous-répertoires `sites-available` et `sites-enabled`. 

Il faut mettre les configurations que l'on veut utiliser dans `sites-available` et les activer avec la commande `a2ensite`. Celà crée dans `sites-enabled` un lien vers la configuration correspondante contenue dans `sites-available`. 

our désactiver une configuration, on utilise la commande `a2dissite`.

Par défaut, apache arrive avec une configuration ssl, donc des certificats et des clés. Sur Ubuntu/Debian les certificats sont dans `/etc/ssl/certs` et les clés dans `/etc/ssl/private`. 

Le fichier `default-ssl.conf` du répertoire `sites-available` contient les directives suivantes :
```
SSLCertificateFile	/etc/ssl/certs/ssl-cert-snakeoil.pem
SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
```
Il semble que ce certificat intègre un ServerName égal à ubuntu.home. On peut s'en contenter pour faire des tests mais il est utile de connaître tout le process de génération des clés et des certificats.

On commence par l'installation des packages nécessaires au serveur.

## installation des packages

```
sudo apt install apache2 gettext
sudo apt install python3-pip
python3 -m pip install --upgrade pip
sudo apt install redis-server mosquitto
pip3 install redis
pip3 install flask
sudo apt install libapache2-mod-wsgi-py3 python-dev-is-python3
sudo a2enmod ssl
sudo a2enmod proxy
sudo a2enmod proxy_http
```
customize mosquitto configuration with `sudo nano /etc/mosquitto/mosquitto.conf` :
```
persistence false
allow_anonymous false
listener 1883
password_file /etc/mosquitto/passwd
```
create credentials :
```
touch /etc/mosquitto/passwd
mosquitto_passwd -b /etc/mosquitto/passwd emonpi emonpimqtt2016
```

to check if ssl and proxy modules are activated :
```
apache2ctl -M | grep ssl
apache2ctl -M | grep proxy
```
## configuration ssl - création d'une clé de chiffrement

### demander un certificat à une autorité de certification (CA)

le plus simple est de passer par [letsencrypt](https://letsencrypt.org/about/) qui est une autorité de certification gratuite

l'outil le plus léger et robuste est acme.sh qui se manipule en ligne de commande : [../security#gandi](../security#gandi)

### installer le certificat sur le serveur et configurer apache

https://plainenglish.io/blog/how-to-securely-deploy-flask-with-apache-in-a-linux-server-environment

Ce qui suit détaille la configuration apache au niveau du serveur, mais si l'on veut que le site soit accessible de l'extérieur, il faut avoir préalablement autorisé la régle NAT https sur le routeur/BOX

#### default-ssl

cf https://httpd.apache.org/docs/2.4/ssl/ssl_howto.html

and https://httpd.apache.org/docs/2.4/fr/bind.html

on part du principe qu'on clone l'[app_server](https://github.com/Open-Building-Management/app_server/) dans `/opt/obm`

```
<IfModule mod_ssl.c>
    <VirtualHost _default_:443>
        ServerName emoncms.dromotherm.com
        ServerAlias emoncms.dromotherm.com
        ServerAdmin webmaster@localhost

        WSGIDaemonProcess try user=alexandrecuer group=alexandrecuer threads=15>
        WSGIScriptAlias /try /opt/obm/app_server/app.wsgi
        <Directory /opt/obm/app_server>
             WSGIProcessGroup try
             WSGIApplicationGroup %{GLOBAL}
             WSGIScriptReloading On
             Options Indexes FollowSymLinks
             AllowOverride None
             Require all granted
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        SSLEngine on
        SSLCertificateFile /data/certificates/cert.pem
        SSLCertificateKeyFile /data/certificates/privkey.pem

        <FilesMatch "\.(cgi|shtml|phtml|php)$">
            SSLOptions +StdEnvVars
        </FilesMatch>
        <Directory /usr/lib/cgi-bin>
            SSLOptions +StdEnvVars
        </Directory>
    </VirtualHost>
</IfModule>
```
#### 000-default
```
VirtualHost *:80>
    ServerName emoncms.dromotherm.com
    ServerAlias emoncms.dromotherm.com
    Redirect permanent / https://emoncms.dromotherm.com/

    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

#### check enabled conf files in apache

```
a2query -s
default-ssl (enabled by site administrator)
000-default (enabled by site administrator)
```
Pour activer les conf, comme déjà évoqué, on utilise la commande debian `a2ensite` :

```
sudo a2ensite default-ssl
sudo systemctl reload apache2
```

# conteneur emoncms avec alpine en https sur le réseau local !

Dans une distribution alpine, les fichiers de configuration du serveur apache sont dans `/etc/apache2`, comme pour ubuntu.

Il y a un fichier `httpd.conf` et un sous-répertoire `conf.d` qui contient des configurations que le fichier `httpd.conf` charge puisqu'il comporte la directive `IncludeOptional /etc/apache2/conf.d/*.conf`

Pas besoin de rajouter des instructions de type `Listen 80` ou `Listen 443`. 

Elles sont déjà incluses dans le paramétrage de base : 
- `Listen 80` est dans `httpd.conf`
- `Listen 443` est dans `conf.d\ssl.conf`

Sur Alpine, on trouve les certificats et les clés dans `/etc/ssl/apache2/` sous les noms `server.pem` et `server.key`

cf https://community.home-assistant.io/t/connecting-to-ha-locally-using-https/566441/47

sur la machine hôte, création d'une clé de chiffrement pour une utilisation en local : self signed key

```
openssl genrsa -out alexjunk.key 2048
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout alexjunk.key -out alexjunk.crt
```
on stocke les clés sur la machine hôte dans `/etc/ssl/certs`, dans un dossier `bios` qu'on donne au superutilisateur, on peut alors monter ce dossier dans le conteneur

Lorsqu'on génère le crt, on peut répondre ce qu'on veut à la série de questions, sauf pour le FQDN (Fully Qualified Domain Name)

contenu de /var/log/apache2/error.log
```
[Sun Jan 28 17:25:37.206944 2024] [ssl:warn] [pid 134] AH01906: localhost:443:0 server certificate is a CA certificate (BasicConstraints: CA == TRUE !?)
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message
[Sun Jan 28 17:25:37.239321 2024] [ssl:warn] [pid 134] AH01906: localhost:443:0 server certificate is a CA certificate (BasicConstraints: CA == TRUE !?)
[Sun Jan 28 17:25:37.242679 2024] [mpm_prefork:notice] [pid 134] AH00163: Apache/2.4.58 (Unix) PHP/8.1.26 OpenSSL/3.1.4 configured -- resuming normal operations
[Sun Jan 28 17:25:37.242697 2024] [core:notice] [pid 134] AH00094: Command line: '/usr/sbin/httpd -D FOREGROUND'

```
si on ne fournit pas le bon FQDN, on a les lignes d'erreur en plus `localhost:443:0 server certificate does NOT include an ID which matches the server name`

```
[Sun Jan 28 11:42:30.110706 2024] [ssl:warn] [pid 311] AH01906: localhost:443:0 server certificate is a CA certificate (BasicConstraints: CA == TRUE !?)
[Sun Jan 28 11:42:30.110747 2024] [ssl:warn] [pid 311] AH01909: localhost:443:0 server certificate does NOT include an ID which matches the server name
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message
[Sun Jan 28 11:42:30.125365 2024] [ssl:warn] [pid 311] AH01906: localhost:443:0 server certificate is a CA certificate (BasicConstraints: CA == TRUE !?)
[Sun Jan 28 11:42:30.125389 2024] [ssl:warn] [pid 311] AH01909: localhost:443:0 server certificate does NOT include an ID which matches the server name
[Sun Jan 28 11:42:30.128783 2024] [mpm_prefork:notice] [pid 311] AH00163: Apache/2.4.58 (Unix) PHP/8.1.26 OpenSSL/3.1.4 configured -- resuming normal operations
[Sun Jan 28 11:42:30.128799 2024] [core:notice] [pid 311] AH00094: Command line: '/usr/sbin/httpd -D FOREGROUND'
```
**cette erreur n'est pas bloquante**

# serveur flask de conteneurs en mode purement local pour faire du développement
on peut avoir ce genre d'erreur lorsqu'on a cloné le dépôt github dans son home, qu'on crée un fichier default.ssl et qu'on l'active :
```
[Mon Jan 29 15:01:17.092682 2024] [core:error] [pid 31249:tid 140349691373120] (13)Permission denied: [client 127.0.0.1:57462] AH00035: access to /try/ denied (filesystem path '/home/alexandrecuer/Documents') because search permissions are missing on a component of the path
```
Il faut ajouter des permissions d'exécution sur son home :
```
namei -mol /home/alexandrecuer/Documents/GitHub/sandbox/apache/flask_https
f: /home/alexandrecuer/Documents/GitHub/sandbox/apache/flask_https
drwxr-xr-x root          root          /
drwxr-xr-x root          root          home
drwxr-x--- alexandrecuer alexandrecuer alexandrecuer
drwxr-xr-x alexandrecuer alexandrecuer Documents
drwxrwxr-x alexandrecuer alexandrecuer GitHub
drwxrwxr-x alexandrecuer alexandrecuer sandbox
drwxrwxr-x alexandrecuer alexandrecuer apache
drwxrwxr-x alexandrecuer alexandrecuer flask_https
```
on applique les bonnes permissions :
```
chmod +x /home/alexandrecuer
```
On vérifie :
```
namei -mol /home/alexandrecuer/Documents/GitHub/sandbox/apache/flask_https
f: /home/alexandrecuer/Documents/GitHub/sandbox/apache/flask_https
drwxr-xr-x root          root          /
drwxr-xr-x root          root          home
drwxr-x--x alexandrecuer alexandrecuer alexandrecuer
drwxr-xr-x alexandrecuer alexandrecuer Documents
drwxrwxr-x alexandrecuer alexandrecuer GitHub
drwxrwxr-x alexandrecuer alexandrecuer sandbox
drwxrwxr-x alexandrecuer alexandrecuer apache
drwxrwxr-x alexandrecuer alexandrecuer flask_https
```

