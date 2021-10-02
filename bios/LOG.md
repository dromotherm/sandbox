bios utilise log2ram pour le management des fichiers log en ram

pour trouver les gros fichiers dans /var/log

```
sudo du -a /var/log/* | sort -n -r | head -n 30
```
