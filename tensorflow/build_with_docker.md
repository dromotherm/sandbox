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
pour construire une image à partir d'un dockerfile :

```
docker build -t alex_aarch64 -f tensorflow/tools/ci_build/Dockerfile.pi-python39 tensorflow/tools/ci_build
```

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
# suppression d'images

```
docker image rm nom_image ou id_image
```
Attention, on ne pas supprimer des images qui sont mobilisés dans des containers, même arrêtés

supprimer tous les containers stoppés :
```
docker container prune
```

