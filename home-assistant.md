# home-assistant

https://medium.com/geekculture/home-assistant-with-docker-1a96b4aec023

## ha web server is aiohttp

https://community.home-assistant.io/t/what-is-the-web-server-of-home-assistant/67107

NOW : https://github.com/home-assistant/core/tree/master/homeassistant/components/http

AT THE ORIGIN : https://github.com/home-assistant/core/tree/376d4e4fa0bbcbfa07646f49f9d8fd56c8c0df3c/homeassistant/components/http

https://github.com/aio-libs/aiohttp

https://docs.aiohttp.org/en/stable/

## run ha with a venv

https://home-assistant-china.github.io/docs/installation/virtualenv/

https://community.home-assistant.io/t/installing-home-assistant-core-in-a-python-venv-when-your-distros-python-version-is-obsolete/217048

## run ha in docker

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

# philosophy 

https://www.home-assistant.io/blog/2016/01/19/perfect-home-automation/

## community add-ons project

https://github.com/hassio-addons

## dev doc

https://developers.home-assistant.io/docs/add-ons

## add template integration and create a sensor entry

on ajoute l'intégration si on ne l'a pas

![](https://github.com/dromotherm/sandbox/assets/43913055/4275457b-643f-4ba4-9085-710a1cdbeaba)

par défaut un site météo envoie les données suivantes :

![](https://github.com/dromotherm/sandbox/assets/43913055/2acfe4ec-6f43-48c8-87c5-3eb2b5af31cf)

On crée un capteur en ajoutant une entrée de template

![](https://github.com/dromotherm/sandbox/assets/43913055/216990c1-7d30-4556-b615-b2935588cabd)

![](https://github.com/dromotherm/sandbox/assets/43913055/82ed30e8-8d30-4a3c-9896-0280da39d40a)

![](https://github.com/dromotherm/sandbox/assets/43913055/d2832a97-7232-4420-afc0-30b25388ffa2)

![](https://github.com/dromotherm/sandbox/assets/43913055/793a88b3-1d3e-4e2a-996c-c6340b45f354)

## add mqtt integration and test if payload can be sent to emoncms

![](https://github.com/dromotherm/sandbox/assets/43913055/28768737-0166-4570-8028-e9beef7b0666)

![](https://github.com/dromotherm/sandbox/assets/43913055/5b4b3cff-ab40-4abc-a36f-cd9767f405a8)

## adding automation to post a sensor value

![image](https://github.com/dromotherm/sandbox/assets/24553739/3734e56d-01a2-4fd2-8cc8-75a786b20940)

pour envoyer plusieurs valeurs toutes les minutes:

<img width="447" alt="image" src="https://github.com/dromotherm/sandbox/assets/43913055/33f54297-34f3-4bfb-9866-3927bae69a04">

