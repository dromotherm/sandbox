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
