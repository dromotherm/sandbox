
Télécharger un fichier quant ssh est activé : utilisation de la commande scp.

Il faut connaître l'emplacement du fichier sur la machine distante, içi `/var/log/bios/bios.log.1`

Le `.` à la fin de la commande signifie que le fichier téléchargé sera dans le répertoire courant
```
scp user@176.149.2.179:/var/log/bios/bios.log.1 .
```
Içi, on télécharge un fichier depuis l'ordinateur distant sur l'ordinateur hote (ie depuis lequel on lance scp)

On peut évidemment faire la chose inverse :
```
cd ZZ_cloud/
cd 4_very_successfull/
ls
4parsChh_begin.png  4parsChh_end.png  4parsChh.h5  4parsChh.png
```
puis :
```
scp 4parsChh.h5 pi@192.168.1.22:.
```
