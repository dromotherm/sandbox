# Installation de Redis sur Ubuntu et interaction avec PHP

```
sudo apt install redis-server
```
La sortie devrait être la suivante :
```
[sudo] Mot de passe de alexandrecuer : 
Lecture des listes de paquets... Fait
Construction de l'arbre des dépendances       
Lecture des informations d'état... Fait
Les paquets supplémentaires suivants seront installés : 
  libjemalloc1 redis-tools
Paquets suggérés :
  ruby-redis
Les NOUVEAUX paquets suivants seront installés :
  libjemalloc1 redis-server redis-tools
0 mis à jour, 3 nouvellement installés, 0 à enlever et 0 non mis à jour.
Il est nécessaire de prendre 634 ko dans les archives.
Après cette opération, 3 012 ko d'espace disque supplémentaires seront utilisés.
Souhaitez-vous continuer ? [O/n] o
Réception de :1 http://fr.archive.ubuntu.com/ubuntu bionic/universe amd64 libjemalloc1 amd64 3.6.0-11 [82,4 kB]
Réception de :2 http://fr.archive.ubuntu.com/ubuntu bionic-updates/universe amd64 redis-tools amd64 5:4.0.9-1ubuntu0.2 [516 kB]
Réception de :3 http://fr.archive.ubuntu.com/ubuntu bionic-updates/universe amd64 redis-server amd64 5:4.0.9-1ubuntu0.2 [35,4 kB]
634 ko réceptionnés en 1s (498 ko/s) 
Sélection du paquet libjemalloc1 précédemment désélectionné.
(Lecture de la base de données... 310224 fichiers et répertoires déjà installés.)
Préparation du dépaquetage de .../libjemalloc1_3.6.0-11_amd64.deb ...
Dépaquetage de libjemalloc1 (3.6.0-11) ...
Sélection du paquet redis-tools précédemment désélectionné.
Préparation du dépaquetage de .../redis-tools_5%3a4.0.9-1ubuntu0.2_amd64.deb ...
Dépaquetage de redis-tools (5:4.0.9-1ubuntu0.2) ...
Sélection du paquet redis-server précédemment désélectionné.
Préparation du dépaquetage de .../redis-server_5%3a4.0.9-1ubuntu0.2_amd64.deb ...
Dépaquetage de redis-server (5:4.0.9-1ubuntu0.2) ...
Paramétrage de libjemalloc1 (3.6.0-11) ...
Paramétrage de redis-tools (5:4.0.9-1ubuntu0.2) ...
Paramétrage de redis-server (5:4.0.9-1ubuntu0.2) ...
Created symlink /etc/systemd/system/redis.service → /lib/systemd/system/redis-server.service.
Created symlink /etc/systemd/system/multi-user.target.wants/redis-server.service → /lib/systemd/system/redis-server.service.
Traitement des actions différées (« triggers ») pour libc-bin (2.27-3ubuntu1.2) ...
Traitement des actions différées (« triggers ») pour systemd (237-3ubuntu10.42) ...
Traitement des actions différées (« triggers ») pour man-db (2.8.3-2ubuntu0.1) ...
Traitement des actions différées (« triggers ») pour ureadahead (0.100.0-21) ...
ureadahead will be reprofiled on next reboot
```
Redis est dores et déjà opérationnel à ce stade :
```
sudo systemctl status redis-server
● redis-server.service - Advanced key-value store
   Loaded: loaded (/lib/systemd/system/redis-server.service; enabled; vendor preset: enabled)
   Active: active (running) since Sun 2020-09-20 18:27:24 CEST; 21s ago
     Docs: http://redis.io/documentation,
           man:redis-server(1)
 Main PID: 6881 (redis-server)
    Tasks: 4 (limit: 4915)
   CGroup: /system.slice/redis-server.service
           └─6881 /usr/bin/redis-server 127.0.0.1:6379

sept. 20 18:27:24 alexandrecuer-PORTEGE-R30-A systemd[1]: Starting Advanced key-value store...
sept. 20 18:27:24 alexandrecuer-PORTEGE-R30-A systemd[1]: redis-server.service: Can't open PID file /var/run/redis/redis-server.pid (yet?) a
sept. 20 18:27:24 alexandrecuer-PORTEGE-R30-A systemd[1]: Started Advanced key-value store.
```
Pour vérifier, on peut lancer la ligne de commande :
```
redis-cli
127.0.0.1:6379> ping
PONG
127.0.0.1:6379> set test "It's working!"
OK
127.0.0.1:6379> get test
"It's working!"
127.0.0.1:6379> exit
```
Sur Ubuntu, php est déjà préinstallé
```
sudo apt-get install -y php
Lecture des listes de paquets... Fait
Construction de l'arbre des dépendances       
Lecture des informations d'état... Fait
php est déjà la version la plus récente (1:7.2+60ubuntu1).
0 mis à jour, 0 nouvellement installés, 0 à enlever et 0 non mis à jour.
```



On installe phpRedisAdmin pour voir si tout fonctionne correctement
```
cd /var/www
sudo git clone https://github.com/ErikDubbelboer/phpRedisAdmin.git
cd phpRedisAdmin/
sudo git clone https://github.com/nrk/predis.git vendor
cd /var/www/html
sudo ln -s /var/www/phpRedisAdmin
sudo systemctl daemon-reload
sudo systemctl restart apache2
```

```
