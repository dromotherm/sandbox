https://openclassrooms.com/fr/courses/1733551-gerez-votre-serveur-linux-et-ses-services/5236081-mettez-en-place-un-reverse-proxy-avec-nginx

NPM = nginx proxy manager

Dans un système web moderne multi applications, les ports sont souvent nombreux. 

Exemple sur une machine bios :
- 8443 et 8081 pour themis/emoncms
- 7883 pour mosquitto
- 3000 pour admin
- 443 et 80 pour le reverse proxy NPM

Sur le routeur lui-même, une régle NAT existe sur le port 443 pour offrir un accès à son interface admin

Si on décide d'utiliser NPM pour autre chose que de la génération de certificats, **il faut modifer la régle NAT existante sur le port 443 et pointant sur l'interface admin du routeur et la rediriger vers NPM : ce sera alors NPM qui s'occupera des redirections vers les applis....**

# création d'un domaine avec duckdns

On se connecte sur son profil duckdns (sign in with github) et on crée son domaine

duckdns propose divers types d'installation, dont `linux cron` qui se résume à une instruction shell, qu'on peut recopier et injecter dans les scripts du routeur, exécutés à la construction de la connexion au réseau mobile : Scripts > Up/Down IPv4

# création d'un certificat SSL avec let's encrypt

Avec NPM, on crée 3 certificats SLL, un pour chaque sous-domaines : `themis.ceremacf.duckdns.org`, `admin.ceremacf.duckdns.org`,
`routeur.ceremacf.duckdns.org`

NPM s'occupe automatiquement du renouvellement

# création de 3 proxy hosts avec NPM

On construit 3 sous-domaines pour ceremacf.duckdns.org :

- themis.ceremacf.duckdns.org, pointant vers l'appli de monitoring
- admin.ceremacf.duckdns.org, pointant vers l'interface admin de bios
- routeur.ceremacf.duckdns.org, pointant vers l'intreface admin du routeur

# alternative

**L'autre solution est d'ouvrir un port par applications.**

C'est possible pour l'application de monitoring qui a été sécurisée et peut tourner en https de manière native.

Idem pour l'interface admin du routeur. 

L'interface admin de bios ne pourra pas tourner en https sans implémentation. Il faudrait dans ce cas se contenter d'un accès http. A régler ultérieurement
