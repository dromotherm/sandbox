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
