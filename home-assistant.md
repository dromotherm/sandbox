https://sequr.be/blog/2022/12/home-assistant-container-part-12-migrating-to-podman/

# creating custom integration

https://www.home-assistant.io/blog/2021/05/12/integrations-api/

communication with external device should be managed by an external library

Home Assistant code should always be independent of the logic that is required to work with devices / vendors / protocols / etc.

https://github.com/home-assistant/core/blob/dev/homeassistant/components/openweathermap/coordinator.py

https://github.com/freekode/pyopenweathermap/tree/main

https://github.com/home-assistant/core/pull/118111

## coordinator

https://developers.home-assistant.io/docs/integration_fetching_data/

# running home-assistant

https://medium.com/geekculture/home-assistant-with-docker-1a96b4aec023

## vidéo detection integration

https://github.com/blakeblackshear/frigate

https://frigate.video/

## ha web server is aiohttp

https://community.home-assistant.io/t/what-is-the-web-server-of-home-assistant/67107

NOW : https://github.com/home-assistant/core/tree/master/homeassistant/components/http

AT THE ORIGIN : https://github.com/home-assistant/core/tree/376d4e4fa0bbcbfa07646f49f9d8fd56c8c0df3c/homeassistant/components/http

https://github.com/aio-libs/aiohttp

https://docs.aiohttp.org/en/stable/

## run ha with a venv

https://home-assistant-china.github.io/docs/installation/virtualenv/

https://community.home-assistant.io/t/installing-home-assistant-core-in-a-python-venv-when-your-distros-python-version-is-obsolete/217048

## philosophy 

https://www.home-assistant.io/blog/2016/01/19/perfect-home-automation/

## community add-ons project

https://github.com/hassio-addons

## dev doc

https://developers.home-assistant.io/docs/add-ons

## run ha docker container

https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

for an ephemeral test : 

```
sudo docker run \
  --name homeassistant \
  --rm \
  -e TZ=Europe/Paris \
  -p 8123:8123 \
  -it \
  ghcr.io/home-assistant/home-assistant:stable
```
or 
```
sudo docker run -d \
  --name homeassistant \
  --restart=unless-stopped \
  -v /PATH_TO_YOUR_CONFIG:/config \
  -e TZ=Europe/Paris \
  -p 8123:8123 \
  ghcr.io/home-assistant/home-assistant:stable
```
To use with a reverse proxy running on the host, just add the following lines to the http: section of your configuration.yaml

```
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 192.168.0.0/24
```

## running operating system

with the operating system, if you use the nginx proxy manager addon as the reverse proxy, you need to find its ip on the hassio network

```
docker network inspect hassio
```
you should see an entry like that :
```
"6c3c0445463ee92d86027457e0ef8927396ac635a0bc47b2f9b878a2cd4331cf": {
    "Name": "addon_a0d7b954_nginxproxymanager",
    "EndpointID": "7b43a002b6b23a4fe786d8e0de78c5d0a59e2e4578b5818d91392ff6658bc794",
    "MacAddress": "02:42:ac:1e:21:02",
    "IPv4Address": "172.30.33.2/23",
    "IPv6Address": ""
}
```
so you may adjust the trusted proxy as follow
```
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 172.30.33.0/24
```
and **restart home assistant**

## add mqtt integration and test if payload can be sent to emoncms

![](https://github.com/dromotherm/sandbox/assets/43913055/28768737-0166-4570-8028-e9beef7b0666)

![](https://github.com/dromotherm/sandbox/assets/43913055/5b4b3cff-ab40-4abc-a36f-cd9767f405a8)

## adding automation to post value through MQTT

par défaut, du moins lorsqu'on a installé ha avec la méthode operating system, un site météo envoie les données suivantes qui sont stockées dans les states, içi états :

![](https://github.com/dromotherm/sandbox/assets/43913055/2acfe4ec-6f43-48c8-87c5-3eb2b5af31cf)

pour envoyer plusieurs valeurs toutes les minutes:

![](https://github.com/dromotherm/sandbox/assets/43913055/54c76219-512c-45c7-bc28-049c839ca2e5)


<details id=1>
<summary><h2>add template integration and create a personalised sensor entry</h2></summary>

on ajoute l'intégration template si on ne l'a pas

![](https://github.com/dromotherm/sandbox/assets/43913055/4275457b-643f-4ba4-9085-710a1cdbeaba)

On crée un capteur en ajoutant une entrée de template

![](https://github.com/dromotherm/sandbox/assets/43913055/216990c1-7d30-4556-b615-b2935588cabd)

![](https://github.com/dromotherm/sandbox/assets/43913055/82ed30e8-8d30-4a3c-9896-0280da39d40a)

![](https://github.com/dromotherm/sandbox/assets/43913055/d2832a97-7232-4420-afc0-30b25388ffa2)

![](https://github.com/dromotherm/sandbox/assets/43913055/793a88b3-1d3e-4e2a-996c-c6340b45f354)

</details>

