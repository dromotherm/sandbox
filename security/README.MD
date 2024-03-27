https://github.com/mvt-project/mvt

https://fr.m.wikipedia.org/wiki/Pegasus_(logiciel_espion)

https://github.com/aircrack-ng/aircrack-ng

# SCAN YOUR SITE

https://securityheaders.com/

https://observatory.mozilla.org/

# configure headers in apache and nginx

https://webdock.io/en/docs/how-guides/security-guides/how-to-configure-security-headers-in-nginx-and-apache

in apache.conf

``
LoadModule headers_module modules/mod_headers.so
``

https://julien.io/configuration-de-securite-dans-apache-httpd/

https://www.justegeek.fr/mettre-en-place-permissions-policy-len-tete-http-qui-remplace-le-feature-policy/

# strict transport security

https://www.nginx.com/blog/http-strict-transport-security-hsts-and-nginx/

Une fois que la politique HSTS est présentée à un client, celui-ci met les informations en cache pendant la période max-age spécifiée. Pendant cette période, le navigateur refuse d'accéder au service web via HTTP non crypté et refuse d'accorder des exceptions aux erreurs de certificat (si le site a précédemment présenté un certificat valide et fiable). Si vous spécifiez le paramètre includeSubDomains pour une politique HSTS, ces restrictions s'appliquent également à tous les sous-domaines du domaine actuel.

Il est très difficile d'annuler une stratégie HSTS afin de supprimer la version HTTPS d'un site web ou d'un service. Lorsque vous testez HSTS, utilisez un délai d'attente très court et assurez-vous que vous êtes à l'aise avec les effets et l'obligation de maintenir une version HTTPS de votre site. Lorsque vous mettez en œuvre votre politique HSTS, limitez l'âge maximal et ne l'augmentez que lorsque vous êtes sûr de pouvoir le faire.

pour supprimer les paramètres hsts dans chrome, tapez `chrome://net-internals/#hsts` dans la barre d'adresses

dans mozilla, il faut aller dans l'historique, faire un clic droit sur une des adresses de l'historique mentionnant le site et faire oublier ce site ou forget this site. cela ne marche que sur desktop.

https://www.ssl2buy.com/wiki/how-to-clear-hsts-settings-on-chrome-firefox-and-ie-browsers

https://help.symplify.com/hc/fr-ca/articles/360011108540-Utilisation-de-HTTP-Strict-Transport-Security-HSTS

https://scotthelme.co.uk/setting-up-hsts-in-nginx/

# generate a certificate

https://www.cyberciti.biz/faq/how-to-install-letsencrypt-free-ssltls-for-nginx-certificate-on-alpine-linux/

https://github.com/acmesh-official/acme.sh

install in root mode : 
```
sudo su
cd /opt/OBM
git clone https://github.com/acmesh-official/acme.sh.git
cd ./acme.sh
./acme.sh --install -m alexandrep.cuer@gmail.com
```
you can exit and reconnect as root, create a directory and export your duck dns token :

```
mkdir /data/certificates
export DuckDNS_Token="<token>"
```
then issue a certificate wich will be renewed 1 day after (just for testing) :
```
acme.sh --issue -d ceremacf.duckdns.org --dns dns_duckdns --server letsencrypt --cert-file /data/certificates/cert.pem --key-file /data/certificates/privkey.pem --days 1 --reloadcmd 'docker compose -f /opt/OBM/BIOS2/compose.yaml --profile themis up -d'
```
to check the certificates `acme.sh list`

```
openssl x509 -enddate -noout -in /data/certificates/cert.pem
notAfter=Jun 25 13:42:53 2024 GMT

acme.sh list
Main_Domain           KeyLength  SAN_Domains  CA               Created               Renew
ceremacf.duckdns.org  "ec-256"   no           LetsEncrypt.org  2024-03-27T14:42:57Z  2024-03-28T14:42:57Z
```

to remove a certificate :

```
acme.sh --remove --domain ceremacf.duckdns.org
```

then you can remove it physically

```
rm -Rf ~/.acme.sh/ceremacf.duckdns.org_ecc/
```


