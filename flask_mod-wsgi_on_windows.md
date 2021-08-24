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
py -m app
```

# installer apache 

https://www.apachelounge.com/download/

décompacter sous C:/ ce qui construira un répertoire C:/Apache24 avec tous les fichiers et binaires compilés dedans

pour lancer le serveur et vérifier son fonctionnement, lancer la commande 
```
c:\Apache24\bin>httpd.exe
```

# installer visual C++

https://visualstudio.microsoft.com/fr/visual-cpp-build-tools/

![image](https://user-images.githubusercontent.com/24553739/130683163-44858fc3-460c-40b0-affb-60ef80ce534d.png)

![image](https://user-images.githubusercontent.com/24553739/130683629-3d167940-64a1-426d-8a4d-222955710ca8.png)

# installer mod-wsgi

