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


https://www.ssl2buy.com/wiki/how-to-clear-hsts-settings-on-chrome-firefox-and-ie-browsers

https://help.symplify.com/hc/fr-ca/articles/360011108540-Utilisation-de-HTTP-Strict-Transport-Security-HSTS

https://scotthelme.co.uk/setting-up-hsts-in-nginx/

# generate a certificate

https://www.cyberciti.biz/faq/how-to-install-letsencrypt-free-ssltls-for-nginx-certificate-on-alpine-linux/

https://github.com/acmesh-official/acme.sh
