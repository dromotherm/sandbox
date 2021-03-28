Si on veut créer un alias Apache pour un répertoire, il faut qu'il dispose des permissions adaptées 

```
cd flot-4.2.2
chmod 755 source
chmod 755 lib
chmod 755 $(find examples -type d)
```
