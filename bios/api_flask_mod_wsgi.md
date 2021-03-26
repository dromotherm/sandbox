# mod_wsgi to run a flask API with a apache server 

pour flask : https://flask.palletsprojects.com/en/1.1.x/quickstart/

mod_wsgi source code : https://github.com/GrahamDumpleton/mod_wsgi

https://flask.palletsprojects.com/en/1.1.x/deploying/#deployment

# sur bios avec la stack openenergymonitor préinstallée 

Une fois loggé, on installe flask et flask-cors pour l'utilisateur pi, et on installe mod_wsgi
```
pip3 install flask
pip3 install flask-cors
sudo apt-get install libapache2-mod-wsgi-py3 python-dev
```
flask-cors est indispensable pour les requêtes ajax et pour fonctionner en mode API avec un serveur de cloud qui interroge des machines BIOS terrain.

Le partage des ressources entre origines (Cross-Origin Resource Sharing, CORS) est un mécanisme à base d'en-têtes HTTP supplémentaires pour indiquer aux navigateurs de donner à une application web l'accès à des ressources provenant de l'extérieur. Une application web exécute une requête HTTP inter-origine lorsqu'elle demande une ressource dont l'origine (domaine, protocole ou port) est différente de la sienne. 

Traduit avec www.DeepL.com/Translator (version gratuite)

Traduit avec www.DeepL.com/Translator (version gratuite)
Le mieux est de rajouter les lignes WSGI dans le fichier conf principal : 000-default.conf sur une ubuntu, emoncms.conf sur un emonpi
```
cd /etc/apache2/sites-available
sudo touch emoncms.conf
```
le fichier emoncms.conf devient :
```
<VirtualHost *:80>
    ServerName localhost
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/emoncms

    # Virtual Host specific error log
    ErrorLog /var/log/emoncms/apache2-error.log
    # Access log disabled
    # CustomLog /var/log/emoncms/apache2-access.log combined

    <Directory /var/www/emoncms>
        Options FollowSymLinks
        AllowOverride All
        DirectoryIndex index.php
        Order allow,deny
        Allow from all
    </Directory>

    WSGIDaemonProcess bios user=pi group=pi threads=15
    WSGIScriptAlias /bios /opt/openenergymonitor/BIOS/app.wsgi
    <Directory /opt/openenergymonitor/BIOS/>
      WSGIProcessGroup bios
      WSGIApplicationGroup %{GLOBAL}
      WSGIScriptReloading On
      Options Indexes FollowSymLinks
      AllowOverride None
      Require all granted
    </Directory>

</VirtualHost>
```
on relance apache
```
sudo systemctl restart apache2
```
L'api statistique de BIOS est alors accessible à l'adresse du serveur/bios

# en construisant un nouveau virtual host pour faire des tests locaux
on configure un nouveau virtual host
```
cd /etc/apache2/sites-available
sudo touch bios.conf
```
```
<VirtualHost *:80>
  ServerName localhost
  WSGIDaemonProcess bios user=www-data group=www-data threads=15
  WSGIScriptAlias /bios /home/alexandrecuer/github/BIOS/app.wsgi
  <Directory /home/alexandrecuer/github/BIOS/>
    WSGIProcessGroup bios
    WSGIApplicationGroup %{GLOBAL}
    WSGIScriptReloading On
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
  </Directory>

  ErrorLog ${APACHE_LOG_DIR}/error.log
  LogLevel warn
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```
A noter que si on avait d'autres alias de type WSGI à créer, il faudrait les rajouter dans ce fichier. 
Ne pas faire l'erreur de créer d'autres virtual hosts, qui servent à gérer les domaines et sous-domaines 

on active le virtual host
```
sudo a2ensite bios
Enabling site bios.
To activate the new configuration, you need to run:
  systemctl reload apache2
```

# détails de l'install du paquet mod_wsgi
```
sudo apt-get install libapache2-mod-wsgi-py3 python-dev
```
le retour devrait être le suivant :
```
Lecture des listes de paquets... Fait
Construction de l'arbre des dépendances       
Lecture des informations d'état... Fait
python-dev est déjà la version la plus récente (2.7.15~rc1-1).
python-dev passé en « installé manuellement ».
Les paquets suivants ont été installés automatiquement et ne sont plus nécessaires :
  libnvidia-cfg1-440 libnvidia-common-440 libnvidia-common-455
  libnvidia-common-460 libnvidia-compute-440 libnvidia-decode-440
  libnvidia-encode-440 libnvidia-extra-440 libnvidia-fbc1-440 libnvidia-gl-440
  libnvidia-ifr1-440 linux-hwe-5.4-headers-5.4.0-42
  linux-hwe-5.4-headers-5.4.0-47 linux-hwe-5.4-headers-5.4.0-48
  linux-hwe-5.4-headers-5.4.0-51 linux-hwe-5.4-headers-5.4.0-52
  linux-hwe-5.4-headers-5.4.0-53 linux-hwe-5.4-headers-5.4.0-56
  linux-hwe-5.4-headers-5.4.0-58 nvidia-compute-utils-440 nvidia-dkms-440
  nvidia-utils-440 python3-attr python3-automat python3-click python3-colorama
  python3-constantly python3-hyperlink python3-incremental python3-pam
  python3-pyasn1 python3-serial python3-twisted-bin
  xserver-xorg-video-nvidia-440
Veuillez utiliser « sudo apt autoremove » pour les supprimer.
Les NOUVEAUX paquets suivants seront installés :
  libapache2-mod-wsgi-py3
0 mis à jour, 1 nouvellement installés, 0 à enlever et 14 non mis à jour.
Il est nécessaire de prendre 88,3 ko dans les archives.
Après cette opération, 278 ko d'espace disque supplémentaires seront utilisés.
Souhaitez-vous continuer ? [O/n] o
Réception de :1 http://fr.archive.ubuntu.com/ubuntu bionic-updates/universe amd64 libapache2-mod-wsgi-py3 amd64 4.5.17-1ubuntu1 [88,3 kB]
88,3 ko réceptionnés en 0s (246 ko/s)              
Sélection du paquet libapache2-mod-wsgi-py3 précédemment désélectionné.
(Lecture de la base de données... 495017 fichiers et répertoires déjà installés.)
Préparation du dépaquetage de .../libapache2-mod-wsgi-py3_4.5.17-1ubuntu1_amd64.deb ...
Dépaquetage de libapache2-mod-wsgi-py3 (4.5.17-1ubuntu1) ...
Paramétrage de libapache2-mod-wsgi-py3 (4.5.17-1ubuntu1) ...
apache2_invoke: Enable module wsgi
```
