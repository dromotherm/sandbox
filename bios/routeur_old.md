### Primary LAN

192.168.2.1 : adresse du routeur

DHCP Client : disabled

IP Pool de 192.168.2.2 à 192.168.2.254

On applique, ce qui coupe la connection. On peut relancer BIOS pour reprendre la configuration 

### Secondary LAN & al

DHCP Client : enabled

default gateway : 192.168.1.1

la case "Enable dynamic DHCP leases" n'est pas cochée

**Cette configuration secondaire permet de connecter le second port éthernet à un réseau de type livebox, configuré en 192.168.1.1, ce qui est utile pour disposer d'un accès internet quant il n'y a pas de carte SIM dans le routeur** 

En utilisant l'adresse qui est attribuée par la box, on peut accéder à l'interface de management du routeur depuis un ordi connecté en WIFI à la box

Nota : quant on n'a pas de carte SIM dans le routeur, il faut aller dans Configuration > Mobile WAN, et décocher la case "create connection to mobile network". Sinon le routeur va chercher à établir une connection en permanence.

Si on a un troisième port ethernet, on peut laisser sa configuration inchangée (4.1)

Nota : si le routeur n'a pas de wifi, si on est sans carte SIM et qu'on va rester sur un réseau de type livebox, il faut renseigner la translation d'adresse sur le port 22 pour faire du SSH depuis le réseau livebox

### DNS dynamique

Configuration > Services > DynDNS

on coche la case "Enable DynDNS Client"

on renseigne le Hostname (eg : dromotherm.ddns.net) et dans le champ serveur, on saisit : `dynupdate.no-ip.com`
