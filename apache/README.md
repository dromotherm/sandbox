# serveur flask servant des containers emoncms

Le serveur d'applications permet à un utilisateur qui veut tester emoncms de tirer un numéro de port entre 8080 et 9090 et de lancer un container.


## installation des packages

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
## configuration ssl

Il faut créer une clé de chiffrement et la faire valider par une autorité de certification (CA)

### create CSR on the server

CSR = Certificate Signing Request = message adressé à une Autorité de Certification pour obtenir un certificat d’identité numérique.

cf https://www.noip.com/support/knowledgebase/apache-mod-ssl
```
openssl genrsa -out emoncms.ddns.net.key 2048
openssl req -new -key emoncms.ddns.net.key -out emoncms.ddns.net.csr
```
### use CSR to ask for SSL certificate

https://www.noip.com/support/knowledgebase/configure-rapidssl-basic-dv-ssl

### install certificate on the server and configure apache

https://plainenglish.io/blog/how-to-securely-deploy-flask-with-apache-in-a-linux-server-environment

Ce qui suit détaille la configuration apache au niveau du serveur, mais il faut avoir préalablement autorisé la régle NAT https sur le routeur/BOX

#### default-ssl

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
