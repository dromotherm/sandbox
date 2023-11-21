# dockerfile

pour construire une image à partir d'un dockerfile :

```
docker build -t alex_aarch64 -f tensorflow/tools/ci_build/Dockerfile.pi-python39 tensorflow/tools/ci_build
```


# run image in interactive mode
```
docker run -it tf_ci.pi-python39
root@be8d92ccbfb0:/# 
```


# monter un répertoire externe (ie de la machine hôte) dans le container

içi on monte le répertoire courant qui apparaitra dans le container comme un dossier `scripts`

```
docker run -it -v $(pwd):/scripts tf_ci.pi-python39
```


# gestion des images


pour supprimer une image:
```
docker image rm nom_image ou id_image
```
Attention, on ne peut pas supprimer des images qui sont mobilisées dans des containers, même arrêtés







