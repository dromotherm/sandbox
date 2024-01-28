# serveur flask servant des containers emoncms

Le serveur d'applications permet à un utilisateur qui veut tester emoncms de tirer un numéro de port entre 8080 et 9090 et de lancer un container.


## installation des packages

pour faire simple, la machine hôte tourne sous ubuntu, avec systemd

```
sudo apt install apache2 gettext
sudo apt install python3-pip
python3 -m pip install --upgrade pip
sudo apt install redis-server
pip3 install redis
pip3 install flask
sudo apt install libapache2-mod-wsgi-py3 python-dev-is-python3
sudo a2enmod ssl
sudo a2enmod proxy
sudo a2enmod proxy_http
```
to check if ssl and proxy modules are activated :
```
apache2ctl -M | grep ssl
apache2ctl -M | grep proxy
```
## configuration ssl - création d'une clé de chiffrement

### demander un certificat à une autorité de certification (CA)

1) create CSR on the server

CSR = Certificate Signing Request = message adressé à une Autorité de Certification pour obtenir un certificat d’identité numérique.

cf https://www.noip.com/support/knowledgebase/apache-mod-ssl
```
openssl genrsa -out emoncms.ddns.net.key 2048
openssl req -new -key emoncms.ddns.net.key -out emoncms.ddns.net.csr
```
2) use CSR to ask for SSL certificate

https://www.noip.com/support/knowledgebase/configure-rapidssl-basic-dv-ssl

### installer le certificat sur le serveur et configurer apache

https://plainenglish.io/blog/how-to-securely-deploy-flask-with-apache-in-a-linux-server-environment

Ce qui suit détaille la configuration apache au niveau du serveur, mais s'il l'on veut que le site soit accessible de l'extérieur, il faut avoir préalablement autorisé la régle NAT https sur le routeur/BOX

#### default-ssl

cf https://httpd.apache.org/docs/2.4/ssl/ssl_howto.html

and https://httpd.apache.org/docs/2.4/fr/bind.html

```
<IfModule mod_ssl.c>
    <VirtualHost _default_:443>
        ServerName emoncms.ddns.net
        ServerAlias emoncms.ddns.net
        ServerAdmin webmaster@localhost

        WSGIDaemonProcess try user=alexandrecuer group=alexandrecuer threads=15>
        WSGIScriptAlias /try /opt/obm/app.wsgi
        <Directory /opt/obm/>
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
        SSLCertificateFile /path/to/emoncms_ddns_net.crt
        SSLCertificateKeyFile /path/to/emoncms.ddns.net.key
        SSLCertificateChainFile /path/to/DigiCertCA.crt

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
    ServerName emoncms.ddns.net
    ServerAlias emoncms.ddns.net
    Redirect permanent / https://emoncms.ddns.net/

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

# conteneur emoncms avec alpine en https sur le réseau local !

cf https://community.home-assistant.io/t/connecting-to-ha-locally-using-https/566441/47

sur la machine hôte, création d'une clé de chiffrement pour une utilisation en local : self signed key

```
openssl genrsa -out alexjunk.key 2048
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout alexjunk.key -out alexjunk.crt
```
on stocke les clés sur la machine hôte dans /etc/ssl/certs, dans un dossier bios qu'on donne au superutilisateur

on monte ce dossier dans le conteneur :
```
sudo docker run --rm -p 8081:443 -p 7883:1883 -v /etc/ssl/certs/bios:/cert -it emoncms:alpine3.18
```

contenu de /var/log/apache2/error.log
```
[Sun Jan 28 11:42:30.110706 2024] [ssl:warn] [pid 311] AH01906: localhost:443:0 server certificate is a CA certificate (BasicConstraints: CA == TRUE !?)
[Sun Jan 28 11:42:30.110747 2024] [ssl:warn] [pid 311] AH01909: localhost:443:0 server certificate does NOT include an ID which matches the server name
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message
[Sun Jan 28 11:42:30.125365 2024] [ssl:warn] [pid 311] AH01906: localhost:443:0 server certificate is a CA certificate (BasicConstraints: CA == TRUE !?)
[Sun Jan 28 11:42:30.125389 2024] [ssl:warn] [pid 311] AH01909: localhost:443:0 server certificate does NOT include an ID which matches the server name
[Sun Jan 28 11:42:30.128783 2024] [mpm_prefork:notice] [pid 311] AH00163: Apache/2.4.58 (Unix) PHP/8.1.26 OpenSSL/3.1.4 configured -- resuming normal operations
[Sun Jan 28 11:42:30.128799 2024] [core:notice] [pid 311] AH00094: Command line: '/usr/sbin/httpd -D FOREGROUND'
```
