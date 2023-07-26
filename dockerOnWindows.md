# Windows Subsystem for Linux

on active wsl :
- taper windows features dans la barre de recherche
- puis cocher sous-système windows pour linux




## Enable Virtual Machine Feature

run powershell as an administor :
```
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Outil Gestion et maintenance des images de déploiement
Version : 10.0.19041.844

Version de l’image : 10.0.19045.3208

Activation de la ou des fonctionnalités
[==========================100.0%==========================]
L’opération a réussi.
```
## passer à wsl 2
```
wsl --set-default-version 2
Activez la fonctionnalité Windows de plateforme de machine virtuelle et assurez-vous que la virtualisation est activée dans le BIOS.
Pour plus d’informations, rendez-vous sur https://aka.ms/wsl2-install
```
lors de l'installation de docker, windows peut demander l'install de la version 2 du wsl. On le fait en ligne de commande powershell en mode admin :
```
wsl --update
```

## installer une distribution linux

pour installer une distribution ubuntu :

```
wsl --install -d ubuntu
```
pour lancer cette distribution, il suffit de taper wsl en invité de commande
