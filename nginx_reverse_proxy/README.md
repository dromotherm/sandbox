avant toute chose, il faut avoir un dns dynamique

# création d'un dns dynamique avec duckdns

On se connecte sur son profil duckdns (sign in with github) et on crée son domaine

duckdns propose divers types d'installation, dont `linux cron` qui se résume à une instruction shell, qu'on peut recopier et injecter dans les scripts du routeur, exécutés à la construction de la connexion au réseau mobile : Scripts > Up/Down IPv4

# NPM = nginx proxy manager

IL Y A UN BUG DANS LA CONF HSTS DE NPM : https://gist.github.com/R0GGER/916183fca41f02df1471a6f455e5869f

Le magasin de certificats est dans `/data/proxy/letsencrypt/live`

Les conf des proxy_host sont dans `/data/proxy/nginx/proxy_host`

On peut ajouter des headers pour sécuriser, pour celà ouvrir la configuration et ajouter dans le bloc location :

```
    add_header Referrer-Policy "same-origin";
    add_header X-Frame-Options SAMEORIGIN;
    add_header X-Content-Type-Options nosniff;
    add_header X-XSS-Protection "1; mode=block";
    add_header Permissions-Policy "accelerometer=(), geolocation=(), fullscreen=(), microphone=(), camera=(), display-capture=()";
```

Dans un système web moderne multi applications, les ports sont souvent nombreux. 

Exemple sur une machine bios :
- 8443 et 8081 pour themis/emoncms
- 7883 pour mosquitto
- 3000 pour admin
- 443 et 80 pour le reverse proxy NPM

Sur le routeur de Themis, une régle NAT existe sur le port 443 pour offrir un accès à son interface admin

Si on décide d'utiliser NPM pour autre chose que de la génération de certificats, **il faut modifer la régle NAT existante sur le port 443 et pointant sur l'interface admin du routeur et la rediriger vers NPM : ce sera alors NPM qui s'occupera des redirections vers les applis....**

## création d'un certificat SSL avec let's encrypt

Avec NPM, on crée 3 certificats SSL, un pour chaque sous-domaines : `themis.ceremacf.duckdns.org`, `admin.ceremacf.duckdns.org`,
`routeur.ceremacf.duckdns.org`

NPM s'occupe automatiquement du renouvellement

## création de 3 proxy hosts avec NPM

On construit 3 sous-domaines pour ceremacf.duckdns.org :

- themis.ceremacf.duckdns.org, pointant vers l'appli de monitoring
- admin.ceremacf.duckdns.org, pointant vers l'interface admin de bios
- routeur.ceremacf.duckdns.org, pointant vers l'intreface admin du routeur

# alternative recommandée

**L'autre solution est d'ouvrir un port par applications, par ex 3443 pour l'interface admin et 8443 pour l'application.**

C'est possible nativement pour l'application de monitoring qui a été sécurisée et peut tourner en https de manière native.

Idem pour l'interface admin du routeur. 

L'interface admin de bios nécessite l'utilisation d'un proxy. 

On peut utiliser une image docker de nginx pour cela, en montant une conf intégrant une instruction `proxy_pass`

cf https://openclassrooms.com/fr/courses/1733551-gerez-votre-serveur-linux-et-ses-services/5236081-mettez-en-place-un-reverse-proxy-avec-nginx

Si on choisit cette alternative, il faut un outil pour gérer ses certificats, acme.sh est une bonne option, simple et robuste

