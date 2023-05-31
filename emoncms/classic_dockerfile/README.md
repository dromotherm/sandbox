to use the docker command without sudo
```
sudo groupadd docker
sudo usermod -aG docker $USER
```

to build : `docker build -t emoncms .`

run as a volatile toy : `docker run --rm -it emoncms`

run with datapersistence :
```
docker volume create mariadb_datas
docker volume create ts_datas
docker run --rm -v mariadb_datas:/var/lib/mysql -v ts_datas:/var/opt/emoncms -it emoncms
```
All datas are available on the host in `/var/lib/docker/volumes`
