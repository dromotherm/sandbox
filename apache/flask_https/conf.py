"""configuration file"""
# replace with your CNAME, eg emoncms.ddns.net
CNAME = "localhost"
LOCAL_NAME = "127.0.0.1"
SU_PASS = "your_pass"
DOCKER_IMAGE = "alexjunk/themis:alpine3.18_emoncms11.4.7"
# chemin du fichier apache de configuration des VirtualHosts
APACHE_CONF = "/etc/apache2/sites-available/default-ssl.conf"
# les certificats à monter dans les conteneurs
CERT_DIR = "/etc/ssl/certs/bios"
CRT_FILE = "alexjunk.crt"
KEY_FILE = "alexjunk.key"
# using the host broker
MQTT_HOST = "172.17.0.1"
