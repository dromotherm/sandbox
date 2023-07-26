# Windows Subsystem for Linux

on active wsl

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

```
wsl --set-default-version 2
Activez la fonctionnalité Windows de plateforme de machine virtuelle et assurez-vous que la virtualisation est activée dans le BIOS.
Pour plus d’informations, rendez-vous sur https://aka.ms/wsl2-install
```


pour installer une distribution ubuntu :

```
wsl --install -d ubuntu
```

