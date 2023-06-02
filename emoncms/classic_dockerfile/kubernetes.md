# blog de devops

https://blog.stephane-robert.info

# emoncms

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
