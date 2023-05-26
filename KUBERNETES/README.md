# install cubectl

```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
```

# minicube

```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube start
😄  minikube v1.30.1 sur Ubuntu 18.04
✨  Utilisation du pilote virtualbox basé sur le profil existant
👍  Démarrage du noeud de plan de contrôle minikube dans le cluster minikube
🔄  Redémarrage du virtualbox VM existant pour "minikube" ...
🐳  Préparation de Kubernetes v1.26.3 sur Docker 20.10.23...
    ▪ Génération des certificats et des clés
    ▪ Démarrage du plan de contrôle ...
    ▪ Configuration des règles RBAC ...
🔗  Configuration de bridge CNI (Container Networking Interface)...
    ▪ Utilisation de l'image gcr.io/k8s-minikube/storage-provisioner:v5
🔎  Vérification des composants Kubernetes...
🌟  Modules activés: storage-provisioner, default-storageclass
🏄  Terminé ! kubectl est maintenant configuré pour utiliser "minikube" cluster et espace de noms "default" par défaut.
```
## access to the cluster
```
kubectl get po -A
NAMESPACE     NAME                               READY   STATUS    RESTARTS      AGE
kube-system   coredns-787d4945fb-99pvv           1/1     Running   0             67s
kube-system   etcd-minikube                      1/1     Running   0             80s
kube-system   kube-apiserver-minikube            1/1     Running   0             80s
kube-system   kube-controller-manager-minikube   1/1     Running   0             79s
kube-system   kube-proxy-tsdf4                   1/1     Running   0             67s
kube-system   kube-scheduler-minikube            1/1     Running   0             80s
kube-system   storage-provisioner                1/1     Running   1 (36s ago)   77s
```
## launch dashboard
```
minikube dashboard
```
# the hello app

1) create a deployment
```
kubectl create deployment hello-minikube --image=kicbase/echo-server:1.0
deployment.apps/hello-minikube created
```
2) expose on port 8080
```
kubectl expose deployment hello-minikube --type=NodePort --port=8080
service/hello-minikube exposed
```
3) access to the service
option 1 : `minikube service hello-minikube`
it should return :
```
|-----------|----------------|-------------|-----------------------------|
| NAMESPACE |      NAME      | TARGET PORT |             URL             |
|-----------|----------------|-------------|-----------------------------|
| default   | hello-minikube |        8080 | http://192.168.59.100:31879 |
|-----------|----------------|-------------|-----------------------------|
🎉  Ouverture du service default/hello-minikube dans le navigateur par défaut...
```
option 2 : `kubectl port-forward service/hello-minikube 8080:8080`
it should return :
```
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
Handling connection for 8080
```
