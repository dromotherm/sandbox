## téléchargement

https://www.python.org/downloads/windows/

ou 

https://python.fr.uptodown.com/windows/telecharger

on inclut le chemin dans le path si l'on ne veut pas utiliser la commande `py` a la place de `python`

Démarrer > Paramètres > Système > informations système > Paramètres systèmes avancés > Variable d'environnement > Path

on vérifie qu'on a pip :

```
python -m pip -V
pip 21.1.1 from C:\Users\alexandre.cuer\AppData\Local\Programs\Python\Python39\lib\site-packages\pip (python 3.9)
```
très peu de packages sont dispo :

```
C:\Users\alexandre.cuer\Documents\GitHub\Open-Building-Management.github.io>python -m pip list
Package    Version
---------- -------
pip        21.1.1
setuptools 56.0.0
```
Mais l'installer a tout de même mis en place un certain nombre d'outils de base, dont urllib :

![](images/python_lib_on_windows.png)

# plus de docs

https://docs.python.org/3/using/windows.html
