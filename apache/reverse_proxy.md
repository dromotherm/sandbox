https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-to-configure-Apache-as-a-reverse-proxy-example

https://stackoverflow.com/questions/27710377/redirect-from-subfolder-to-main-domain-with-different-port

about /etc/hosts which is not at all about port :
https://www.baeldung.com/linux/mapping-hostnames-ports

modify emoncms core.php, method get_application_path

```
$subdir = gethostname()."/";
return $path.$subdir;
```
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
