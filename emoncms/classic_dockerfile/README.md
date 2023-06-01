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

