
We are buidling a docker application server but dont want to open ports to outside

We want to rewrite url like http://ip:port to something like http://ip/container_id

For this, we have to use a reverse proxy

# on the web

about /etc/hosts which is not at all about port :
https://www.baeldung.com/linux/mapping-hostnames-ports

https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-to-configure-Apache-as-a-reverse-proxy-example

https://stackoverflow.com/questions/27710377/redirect-from-subfolder-to-main-domain-with-different-port

# our case

## on the host

enable mod_proxy and mod_proxy_http

```
sudo a2enmod proxy
sudo a2enmod proxy_http
```
check mods enabled:

```
apache2ctl -M | grep proxy
proxy_module (shared)
proxy_http_module (shared)
```

## on the container

modify emoncms core.php, method get_application_path

```
$subdir = gethostname()."/";
return $path.$subdir;
```
