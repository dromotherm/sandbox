L'installation de flask se fait comme sous linux.
```
py pip install flask
py pip install flask-cors
```

On fait en sorte que app.py contienne les lignes suivantes :

```
if __name__ == "__main__":
    app.run(debug=True)
```

On peut lancer le serveur de développement via python :

```
cd C:\Users\alexandre.cuer\Desktop\work_2021\GTT\CD63\original
py -m app
```

# installer apache 

https://www.apachelounge.com/download/

décompacter sous C:/ ce qui construira un répertoire C:/Apache24 avec tous les fichiers et binaires compilés dedans

pour lancer le serveur et vérifier son fonctionnement, lancer la commande 
```
c:\Apache24\bin>httpd.exe
```
pour installer en tant que service, ouvrir un invité msdos en tant qu'administrateur 

![image](https://user-images.githubusercontent.com/24553739/130686770-3499291b-b81a-41aa-88b3-e1ca2b7d276d.png)

```
cd C:\Apache24\bin
httpd.exe -k install
```
le retour devrait être le suivant :
```
Installing the 'Apache2.4' service
The 'Apache2.4' service is successfully installed.
Testing httpd.conf....
Errors reported here must be corrected before the service can be started.
```
le service doit être démarré avec un compte qui a des privilèges

![image](https://user-images.githubusercontent.com/24553739/130691028-b49921ce-5f4f-4d69-b63e-8a73baa7f17a.png)

![image](https://user-images.githubusercontent.com/24553739/130691297-26b50719-3025-4507-97d0-1febe5cd1d91.png)


# installer visual C++

https://visualstudio.microsoft.com/fr/visual-cpp-build-tools/

![image](https://user-images.githubusercontent.com/24553739/130683163-44858fc3-460c-40b0-affb-60ef80ce534d.png)

![image](https://user-images.githubusercontent.com/24553739/130683629-3d167940-64a1-426d-8a4d-222955710ca8.png)

# installer mod-wsgi

cf https://modwsgi.readthedocs.io/en/master/
```
py -m pip install mod-wsgi
```
On vérifie que l'installation s'est bien passée via `py -m pip list' et on cherche où le package est installé :
```
py -m pip show mod-wsgi
Name: mod-wsgi
Version: 4.9.0
Summary: Installer for Apache/mod_wsgi.
Home-page: https://www.modwsgi.org/
Author: Graham Dumpleton
Author-email: Graham.Dumpleton@gmail.com
License: Apache License, Version 2.0
Location: c:\users\alexandre.cuer\appdata\local\programs\python\python39\lib\site-packages\mod_wsgi-4.9.0-py3.9-win-amd64.egg
Requires:
Required-by:
```
Le fichier mod_wsgi-express doit être dans c:\users\alexandre.cuer\appdata\local\programs\python\python39\lib\site-packages

![image](https://user-images.githubusercontent.com/24553739/130692706-f2cd4516-01f8-4de6-a0e7-c71fb99f02fa.png)

```
cd c:\users\alexandre.cuer\appdata\local\programs\python\python39\lib\site-packages\scripts
mod_wsgi-express module-config
```
le retour est le suivant :
```
LoadFile "C:/Users/alexandre.cuer/AppData/Local/Programs/Python/Python39/python39.dll"
LoadModule wsgi_module "C:/Users/alexandre.cuer/AppData/Local/Programs/Python/Python39/lib/site-packages/mod_wsgi-4.9.0-py3.9-win-amd64.egg/mod_wsgi/server/mod_wsgi.cp39-win_amd64.pyd"
WSGIPythonHome "C:/Users/alexandre.cuer/AppData/Local/Programs/Python/Python39"
```
On modifie alors le fichier httpd.conf en conséquence :
```
LoadFile "C:/Users/alexandre.cuer/AppData/Local/Programs/Python/Python39/python39.dll"
LoadModule wsgi_module "C:/Users/alexandre.cuer/AppData/Local/Programs/Python/Python39/lib/site-packages/mod_wsgi-4.9.0-py3.9-win-amd64.egg/mod_wsgi/server/mod_wsgi.cp39-win_amd64.pyd"
WSGIPythonHome "C:/Users/alexandre.cuer/AppData/Local/Programs/Python/Python39"

<VirtualHost *:80>
  WSGIScriptAlias /wsgi "C:/Users/alexandre.cuer/Desktop/work_2021/GTT/CD63/original/app.wsgi"
  <Directory "C:/Users/alexandre.cuer/Desktop/work_2021/GTT/CD63/original">
    WSGIApplicationGroup %{GLOBAL}
    WSGIScriptReloading On
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
  </Directory>
</VirtualHost>
```
**il faut bien sûr avoir crée le fichier app.wsgi**
