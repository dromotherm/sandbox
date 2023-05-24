# remplacer un motif par un autre dans un ou plusieurs fichiers

```
sed -i 's/opt\/v\/bios/usr/' bios.py
find hardware -executable -type f | xargs sed -i 's/opt\/v\/bios/usr/'
```
pour rétablir la situation initiale
```
sed -i 's/usr/opt\/v\/bios/' bios.py
find hardware -executable -type f | xargs sed -i 's/usr/opt\/v\/bios/'
```
