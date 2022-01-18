# dockerfile

pour construire une image à partir d'un dockerfile :

```
docker build -t alex_aarch64 -f tensorflow/tools/ci_build/Dockerfile.pi-python39 tensorflow/tools/ci_build
```


# run image in interactive mode
```
docker run -it tf_ci.pi-python39
root@be8d92ccbfb0:/# ls -al
total 38856
drwxr-xr-x   1 root  root      4096 Jan 18 16:01 .
drwxr-xr-x   1 root  root      4096 Jan 18 16:01 ..
-rwxr-xr-x   1 root  root         0 Jan 18 16:01 .dockerenv
drwxr-xr-x   2 root  root      4096 Jan  7 18:12 bazel
drwxr-xr-x   1 root  root      4096 Jan  7 18:04 bin
drwxr-xr-x   2 root  root      4096 Apr 12  2016 boot
-rw-r--r--   1 root  root  39537621 Jan  7 18:09 cmake-3.16.8-Linux-x86_64.sh
drwxr-xr-x   5 root  root       360 Jan 18 16:01 dev
drwxr-xr-x   1 root  root      4096 Jan 18 16:01 etc
drwxr-xr-x   2 root  root      4096 Apr 12  2016 home
drwxr-xr-x   2 root  root      4096 Jan  7 18:02 install
drwxr-xr-x   1 root  root      4096 Jan  7 18:10 lib
drwxr-xr-x   2 root  root      4096 Aug  4 19:01 lib64
drwxr-xr-x   2 root  root      4096 Aug  4 19:00 media
drwxr-xr-x   2 root  root      4096 Aug  4 19:00 mnt
drwxr-xr-x   2 root  root      4096 Aug  4 19:00 opt
drwxr-xr-x   5 30001 30000     4096 Jan  7 18:12 patchelf-0.9
-rw-r--r--   1 root  root    159956 Feb 25  2020 patchelf-0.9.tar.bz2
dr-xr-xr-x 459 root  root         0 Jan 18 16:01 proc
drwx------   1 root  root      4096 Jan  7 18:10 root
drwxr-xr-x   1 root  root      4096 Jan  7 18:03 run
drwxr-xr-x   1 root  root      4096 Aug 31 01:21 sbin
drwxr-xr-x   2 root  root      4096 Aug  4 19:00 srv
dr-xr-xr-x  13 root  root         0 Jan 18 16:01 sys
drwxrwxrwt   1 root  root      4096 Jan  7 18:12 tmp
drwxr-xr-x   1 root  root      4096 Jan  7 18:09 usr
drwxr-xr-x   1 root  root      4096 Aug  4 19:01 var
```


# monter un répertoire externe (ie de la machine hôte) dans le container

içi on monte le répertoire courant qui apparaitra dans le container comme un dossier `scripts`

```
docker run -it -v $(pwd):/scripts tf_ci.pi-python39
```


# gestion des images

pour lister les images docker sur un système

```
docker image ls
REPOSITORY          TAG       IMAGE ID       CREATED        SIZE
tf_ci.pi-python38   latest    ea16632aa9a3   34 hours ago   2.42GB
<none>              <none>    b8d1f060839e   2 days ago     2.37GB
<none>              <none>    003ba125db8f   8 days ago     1.13GB
tf_ci.pi-python37   latest    fc5c6e354999   9 days ago     2.22GB
<none>              <none>    e343656b4760   10 days ago    1.05GB
<none>              <none>    3212335abebd   10 days ago    2.43GB
alex_aarch64        latest    b1f4070f8b10   10 days ago    2.42GB
tf_ci.pi-python39   latest    b1f4070f8b10   10 days ago    2.42GB
hello-world         latest    feb5d9fea6a5   3 months ago   13.3kB
ubuntu              16.04     b6f507652425   4 months ago   135MB
```

pour supprimer une image:
```
docker image rm nom_image ou id_image
```
Attention, on ne pas supprimer des images qui sont mobilisés dans des containers, même arrêtés

supprimer tous les containers stoppés :
```
docker container prune
```
## emplacement sur le disque
```
docker info
docker info | grep -e "Root Dir"
Docker Root Dir: /var/lib/docker
```
les images sont dans /var/lib/docker

pour connaître l'espace occupé par docker et ses images
```
sudo du -c /var/lib/docker
```
