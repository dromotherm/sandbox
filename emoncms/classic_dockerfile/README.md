# the build 

to use the docker command without sudo
```
sudo groupadd docker
sudo usermod -aG docker $USER
```

to build : `docker build -t emoncms .`

# run the emoncms container

run as a volatile toy : `docker run --rm -it emoncms`

run with datapersistence :
```
docker volume create mariadb_datas
docker volume create ts_datas
docker run --rm -v mariadb_datas:/var/lib/mysql -v ts_datas:/var/opt/emoncms -it emoncms
```
All datas are available on the host in `/var/lib/docker/volumes`

To get the container IP address : `docker network inspect bridge`

It should return :
``` 
Containers": {
            "f32b02140d390a23f62f22dc31a6d252895575641963e7a3aa7d1dd2035408aa": {
                "Name": "nifty_jepsen",
                "EndpointID": "1e7981b7156bd37d33b2655d58a2a3ce9e1c7729d4ee1be9a8d33934ea776835",
                "MacAddress": "02:42:ac:11:00:02",
                "IPv4Address": "172.17.0.2/16",
                "IPv6Address": ""
            }
```
The container can be locally reached at 172.17.0.2

![image](https://github.com/dromotherm/sandbox/assets/24553739/5cf5a5fe-28cc-4428-8b2f-55fd222d4f9f)

install mosquitto_pub on the host, via apt : `sudo apt-get install mosquitto-clients`

to post datas : `mosquitto_pub -h 172.17.0.2 -u "emonpi" -P "emonpimqtt2016" -t 'emon/test/t3' -m 15`

![image](https://github.com/dromotherm/sandbox/assets/24553739/c8ff7f7e-a553-481b-96aa-248adfcffda7)

to fetch datas from an emonpi with the sync module : 

![image](https://github.com/dromotherm/sandbox/assets/24553739/d52a0925-bcc5-4eb9-95e3-561a61d91708)

![image](https://github.com/dromotherm/sandbox/assets/24553739/2f1ded4a-6bd2-4d8f-8fc9-75b8860c3e8f)

![image](https://github.com/dromotherm/sandbox/assets/24553739/1f05f9ad-f51a-4680-97c8-b91f352cc85d)

# emoncms base client

if you want to access to the emoncms redis and mysql databases from an external container, you have to launch it on the same namespace

to launch emoncms : 
```
docker run --rm --name=emoncms -it alexjunk/emoncms:0.0.2
```
check the emoncms docker IP address :
```
docker inspect emoncms | grep IPAddress
            "SecondaryIPAddresses": null,
            "IPAddress": "172.17.0.3",
                    "IPAddress": "172.17.0.3",
```
browse to 172.17.0.3 to create the emoncms user so that redis will have a key "user:1"

then run the client :
```
docker run --rm --network=container:emoncms -it client
root@45198f975674:/# ifconfig
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.17.0.3  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:ac:11:00:03  txqueuelen 0  (Ethernet)
        RX packets 40  bytes 7140 (7.1 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 266  bytes 16333 (16.3 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 266  bytes 16333 (16.3 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

root@45198f975674:/# redis-cli
127.0.0.1:6379> keys *
1) "user:1"
127.0.0.1:6379>
```
this technique allows you to create emoncms clients that use its redis and mysql databases

to connect to mysl, use tcp, not socket :
```
mysql -u emoncms --protocol=tcp -pemonpiemoncmsmysql2016 emoncms

Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 2317
Server version: 10.3.38-MariaDB-0ubuntu0.20.04.1 Ubuntu 20.04

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [emoncms]> SHOW TABLES;
+-------------------+
| Tables_in_emoncms |
+-------------------+
| dashboard         |
| feeds             |
| graph             |
| input             |
| multigraph        |
| postprocess       |
| rememberme        |
| schedule          |
| sync              |
| users             |
+-------------------+
10 rows in set (0.001 sec)
```
