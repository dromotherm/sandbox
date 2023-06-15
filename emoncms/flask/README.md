# serveur flask servant des containers emoncms 

```
sudo apt install apache2 gettext
sudo apt install python3-pip
python3 -m pip install --upgrade pip
sudo apt install redis-server
pip3 install redis
pip3 install flask
sudo apt install libapache2-mod-wsgi-py3 python-dev-is-python3
sudo a2enmod ssl
```
to check if ssl module is activated :
```
apache2ctl -M | grep ssl
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this message
 ssl_module (shared)
```
## create csr
cf https://www.noip.com/support/knowledgebase/apache-mod-ssl
```
openssl genrsa -out emoncms.ddns.net.key 2048
openssl req -new -key emoncms.ddns.net.key -out emoncms.ddns.net.csr
```
## ask for ssl certificate
https://www.noip.com/support/knowledgebase/configure-rapidssl-basic-dv-ssl

## install


# check enabled apache conf

```
a2query -s
default-ssl (enabled by site administrator)
000-default (enabled by site administrator)
```
