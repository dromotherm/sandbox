
Official docker image from : https://hub.docker.com/_/influxdb
```
docker run --rm -p 8086:8086 -v alexInfluxVolume:/var/lib/influxdb2 -it influxdb:latest
```
You can access to the app through http://127.0.0.1:8086

Create an organization and a bucket, for example :
- org : obm
- bucket: bios_datas

A token will be initialized.

<details><summary><h1>post data via the API</h1></summary>

Open a shell on the host machine.

Export app address, org, bucket and token as env vars on the host machine :
```
export INFLUX_HOST=http://localhost:8086
export INFLUX_ORG=obm
export INFLUX_BUCKET=bios_datas
export INFLUX_TOKEN=my_super_hard_to_find_token
```

cf https://docs.influxdata.com/influxdb/v2/get-started/write/

posting datas for day 2022-01-01, in a measurement called home

```
curl --request POST \
"$INFLUX_HOST/api/v2/write?org=$INFLUX_ORG&bucket=$INFLUX_BUCKET&precision=s" \
  --header "Authorization: Token $INFLUX_TOKEN" \
  --header "Content-Type: text/plain; charset=utf-8" \
  --header "Accept: application/json" \
  --data-binary "
home,room=Living\ Room temp=21.1,hum=35.9,co=0i 1641024000
home,room=Kitchen temp=21.0,hum=35.9,co=0i 1641024000
home,room=Living\ Room temp=21.4,hum=35.9,co=0i 1641027600
home,room=Kitchen temp=23.0,hum=36.2,co=0i 1641027600
home,room=Living\ Room temp=21.8,hum=36.0,co=0i 1641031200
home,room=Kitchen temp=22.7,hum=36.1,co=0i 1641031200
home,room=Living\ Room temp=22.2,hum=36.0,co=0i 1641034800
home,room=Kitchen temp=22.4,hum=36.0,co=0i 1641034800
home,room=Living\ Room temp=22.2,hum=35.9,co=0i 1641038400
home,room=Kitchen temp=22.5,hum=36.0,co=0i 1641038400
home,room=Living\ Room temp=22.4,hum=36.0,co=0i 1641042000
home,room=Kitchen temp=22.8,hum=36.5,co=1i 1641042000
home,room=Living\ Room temp=22.3,hum=36.1,co=0i 1641045600
home,room=Kitchen temp=22.8,hum=36.3,co=1i 1641045600
home,room=Living\ Room temp=22.3,hum=36.1,co=1i 1641049200
home,room=Kitchen temp=22.7,hum=36.2,co=3i 1641049200
home,room=Living\ Room temp=22.4,hum=36.0,co=4i 1641052800
home,room=Kitchen temp=22.4,hum=36.0,co=7i 1641052800
home,room=Living\ Room temp=22.6,hum=35.9,co=5i 1641056400
home,room=Kitchen temp=22.7,hum=36.0,co=9i 1641056400
home,room=Living\ Room temp=22.8,hum=36.2,co=9i 1641060000
home,room=Kitchen temp=23.3,hum=36.9,co=18i 1641060000
home,room=Living\ Room temp=22.5,hum=36.3,co=14i 1641063600
home,room=Kitchen temp=23.1,hum=36.6,co=22i 1641063600
home,room=Living\ Room temp=22.2,hum=36.4,co=17i 1641067200
home,room=Kitchen temp=22.7,hum=36.5,co=26i 1641067200
"
```
## use the data explorer to visualize the datas

You can see the measurement

![image](https://github.com/dromotherm/sandbox/assets/24553739/0396bec9-e5b4-4dfe-b5af-4ab68974fcef)

But you cannot see any fields

![image](https://github.com/dromotherm/sandbox/assets/24553739/51df6a45-9077-40bf-88d9-1af4e0775d20)

You have to specify a custom time range :

![image](https://github.com/dromotherm/sandbox/assets/24553739/f28198c6-d4a8-40ba-a89e-d561720d3ef2)

![image](https://github.com/dromotherm/sandbox/assets/24553739/203c8835-3126-45db-94b3-c6fe2b80d478)

![image](https://github.com/dromotherm/sandbox/assets/24553739/3d7461da-7046-49e6-a981-f01aa503b36a)

You can now see fields and room

![image](https://github.com/dromotherm/sandbox/assets/24553739/9928702f-0476-4781-8be0-c15630dcf71d)

</details>

# post via MQTT

Open a shell on the host machine, in order to run a telegraf container

Export some env vars on the host machine, assuming its IP to be 192.168.1.53 :
```
export INFLUX_HOST=http://192.168.1.53:8086
export INFLUX_ORG=obm
export INFLUX_BUCKET=bios_datas
export INFLUX_TOKEN=my_super_hard_to_find_token
```
Create a telegraf.conf file : `nano telegraf.conf` with the following content : 

```
# Configuration for telegraf agent
[agent]
  debug = true
  omit_hostname = true

[[outputs.influxdb_v2]]
  urls = ["$INFLUX_HOST"]
  token = "$INFLUX_TOKEN"
  organization = "$INFLUX_ORG"
  bucket = "$INFLUX_BUCKET"

# Read metrics from MQTT topic(s)
[[inputs.mqtt_consumer]]
  servers = ["tcp://192.168.1.53:1883"]
  username = "emonpi"
  password = "emonpimqtt2016"

  ## Topics that will be subscribed to.
  topics = ["emon/#"]
  data_type = "float"
  data_format = "json"
```
Start the telegraf container :
```
docker run --rm -v $PWD/telegraf.conf:/etc/telegraf/telegraf.conf:ro -e INFLUX_TOKEN -e INFLUX_HOST -e INFLUX_BUCKET -e INFLUX_ORG -it telegraf
```
Post a json payload :
```
mosquitto_pub -h 192.168.1.53 -p 1883 -u "emonpi" -P "emonpimqtt2016" -t 'emon/ouah' -m "{\"t7\":132,\"t6\":23.6}"
```

