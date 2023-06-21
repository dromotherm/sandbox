L'idée est de produire des containers avec emoncms/themis accessible en https sur le port 443 et en http sur le port 80

Le résultat est la production d'un Dockerfile permettant d'embarquer les clés de cryptage à l'intérieur du container.

Donc pas d'image en ligne sur le docker Hub

[../emoncms/emoncms_lamp/Dockerfile.ssl](../emoncms/emoncms_lamp/Dockerfile.ssl)

Ensuite, c'est le serveur d'application flask qui se charge de la configuration du serveur apache sur l'hôte pour que les applications soient accessibles sans avoir besoin d'ouvrir d'autres ports que les ports 80 et 443. On passe par un reverse proxy. 

# https et proxy

https://stackoverflow.com/questions/18872482/error-during-ssl-handshake-with-remote-server

# https and ssl certificate

https://web.dev/enable-https/

# activer le https à l'intérieur d'un container

https://forums.docker.com/t/setup-local-domain-and-ssl-for-php-apache-container/116015

https://time2hack.com/dockerize-php-app-with-apache-on-https/

https://codeburst.io/http-server-on-docker-with-https-7b5468f72874

https://mindsers.blog/post/https-using-nginx-certbot-docker/

https://www.devopsschool.com/blog/how-to-configure-docker-container-with-https/
