# deploy emoncms to kubernetes 

## Day 1

en parcourant un blog de devops https://blog.stephane-robert.info

create a deployment file :
```
kubectl create deployment --image=alexjunk/emoncms:0.0.2 emoncms --dry-run=client -o yaml > emoncms_deployment.yaml
```
edit the deployment file and add `imagePullPolicy: Never` :
```
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: emoncms
  name: emoncms
spec:
  replicas: 1
  selector:
    matchLabels:
      app: emoncms
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: emoncms
    spec:
      containers:
      - image: alexjunk/emoncms:0.0.2
        name: emoncms
        imagePullPolicy: Never
        resources: {}
status: {}
```
apply the deployment :
```
kubectl apply -f emoncms_deployment.yaml
```
expose the deployment :
```
kubectl expose deployment emoncms --port 80 --dry-run=client -o yaml > emoncms_service.yaml
kubectl apply -f emoncms_service.yaml
```
check the app logs
```
kubectl logs -f -l app=emoncms
2023-06-02 18:17:08,473 INFO success: mariadb entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2023-06-02 18:17:08,473 INFO success: redis-server entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2023-06-02 18:17:08,474 INFO success: mosquitto-server entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2023-06-02 18:17:08,474 INFO success: apache entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2023-06-02 18:17:08,474 INFO success: emoncms_mqtt entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2023-06-02 18:17:08,474 INFO success: service-runner entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2023-06-02 18:17:08,474 INFO success: feedwriter entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2023-06-02 18:17:09,478 INFO exited: feedwriter (exit status 0; expected)
2023-06-02 18:17:10,484 INFO spawned: 'feedwriter' with pid 59
2023-06-02 18:17:11,486 INFO success: feedwriter entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
```
check the service :
```
kubectl describe service emoncms
Name:              emoncms
Namespace:         default
Labels:            app=emoncms
Annotations:       <none>
Selector:          app=emoncms
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.101.128.68
IPs:               10.101.128.68
Port:              <unset>  80/TCP
TargetPort:        8080/TCP
Endpoints:         10.244.0.21:8080
Session Affinity:  None
Events:            <none>
```
we are running minikube cluster, so connect to the cluster via ssh :
```
minikube ssh
curl 10.244.0.21
```
you should see the html :-)

`minikube service emoncms` ouvre l'application dans le navigateur

## Day 2

to get the cluster ip : 
```
minikube ip
192.168.49.2
```
il semble qu'on peut faire la même chose avec un simple pod

On crée le fichier emoncms_pod.yaml :
```
apiVersion: v1
kind: Pod
metadata:
  name: emoncms
spec:
  containers:
  - name: emoncms
    image: alexjunk/emoncms:0.0.2
    ports:
    - containerPort: 80
      hostPort: 32443
```
kubernetes va chercher l'e container source sur docker, donc le pod met un peu de temps à passer en running

sur le dashboard, on a la vision suivante :

![image](https://github.com/dromotherm/sandbox/assets/24553739/a479119d-19a9-41f7-ab3b-aa9ab5a3d59d)

emoncms est disponible à l'adresse suivante sur le browser de la machine hôte : http://192.168.49.2:32443

pour rendre le pod accessible depuis une autre machine du réseau local, il faut faire du routage.

pour visualiser les tables de routage :
```
sudo iptables -t nat --line-numbers -L
Chain PREROUTING (policy ACCEPT)
num  target     prot opt source               destination         
1    DOCKER     all  --  anywhere             anywhere             ADDRTYPE match dst-type LOCAL

Chain INPUT (policy ACCEPT)
num  target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
num  target     prot opt source               destination         
1    DOCKER     all  --  anywhere            !localhost/8          ADDRTYPE match dst-type LOCAL

Chain POSTROUTING (policy ACCEPT)
num  target     prot opt source               destination         
1    MASQUERADE  all  --  192.168.49.0/24      anywhere            
2    MASQUERADE  all  --  172.17.0.0/16        anywhere            
3    MASQUERADE  tcp  --  192.168.49.2         192.168.49.2         tcp dpt:32443
4    MASQUERADE  tcp  --  192.168.49.2         192.168.49.2         tcp dpt:8443
5    MASQUERADE  tcp  --  192.168.49.2         192.168.49.2         tcp dpt:5000
6    MASQUERADE  tcp  --  192.168.49.2         192.168.49.2         tcp dpt:2376
7    MASQUERADE  tcp  --  192.168.49.2         192.168.49.2         tcp dpt:ssh

Chain DOCKER (2 references)
num  target     prot opt source               destination         
1    RETURN     all  --  anywhere             anywhere            
2    RETURN     all  --  anywhere             anywhere            
3    DNAT       tcp  --  anywhere             localhost            tcp dpt:49173 to:192.168.49.2:32443
4    DNAT       tcp  --  anywhere             localhost            tcp dpt:49174 to:192.168.49.2:8443
5    DNAT       tcp  --  anywhere             localhost            tcp dpt:49175 to:192.168.49.2:5000
6    DNAT       tcp  --  anywhere             localhost            tcp dpt:49176 to:192.168.49.2:2376
7    DNAT       tcp  --  anywhere             localhost            tcp dpt:49177 to:192.168.49.2:22
```
pour supprimer la ligne 2 dans PREROUTING s'il y en avait une :
```
sudo iptables -t nat -D PREROUTING 2
```
pour router le traffic entrant depuis le réseau local vers le pod emoncms :
```
sudo iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 192.168.49.2:32443
```
pour que l'on puisse aussi utiliser l'adresse 192.168.1.25:8080 depuis le browser de la machine hôte :
```
sudo iptables -t nat -A DOCKER -p tcp -s 192.168.1.25 --dport 8080 -j DNAT --to-destination 192.168.49.2:32443
```
la table de routage est devenue la suivante :

```
sudo iptables -t nat --line-numbers -L
Chain PREROUTING (policy ACCEPT)
num  target     prot opt source               destination         
1    DOCKER     all  --  anywhere             anywhere             ADDRTYPE match dst-type LOCAL
2    DNAT       tcp  --  anywhere             anywhere             tcp dpt:http-alt to:192.168.49.2:32443

Chain INPUT (policy ACCEPT)
num  target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
num  target     prot opt source               destination         
1    DOCKER     all  --  anywhere            !localhost/8          ADDRTYPE match dst-type LOCAL

Chain POSTROUTING (policy ACCEPT)
num  target     prot opt source               destination         
1    MASQUERADE  all  --  192.168.49.0/24      anywhere            
2    MASQUERADE  all  --  172.17.0.0/16        anywhere            
3    MASQUERADE  tcp  --  192.168.49.2         192.168.49.2         tcp dpt:32443
4    MASQUERADE  tcp  --  192.168.49.2         192.168.49.2         tcp dpt:8443
5    MASQUERADE  tcp  --  192.168.49.2         192.168.49.2         tcp dpt:5000
6    MASQUERADE  tcp  --  192.168.49.2         192.168.49.2         tcp dpt:2376
7    MASQUERADE  tcp  --  192.168.49.2         192.168.49.2         tcp dpt:ssh

Chain DOCKER (2 references)
num  target     prot opt source               destination         
1    RETURN     all  --  anywhere             anywhere            
2    RETURN     all  --  anywhere             anywhere            
3    DNAT       tcp  --  anywhere             localhost            tcp dpt:49173 to:192.168.49.2:32443
4    DNAT       tcp  --  anywhere             localhost            tcp dpt:49174 to:192.168.49.2:8443
5    DNAT       tcp  --  anywhere             localhost            tcp dpt:49175 to:192.168.49.2:5000
6    DNAT       tcp  --  anywhere             localhost            tcp dpt:49176 to:192.168.49.2:2376
7    DNAT       tcp  --  anywhere             localhost            tcp dpt:49177 to:192.168.49.2:22
8    DNAT       tcp  --  alexandrecuer-portege-r30-a.home  anywhere             tcp dpt:http-alt to:192.168.49.2:32443
```
