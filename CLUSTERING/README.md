https://raspberrytips.fr/installation-cluster-raspberry-pi/

https://raspberrytips.fr/utilite-cluster-raspberry-pi/

https://containerd.io/

https://www.grottedubarbu.fr/cluster-raspberry/

https://github.com/alexellis/k8s-on-raspbian

https://blog.alexellis.io/your-serverless-raspberry-pi-cluster/

https://blog.alexellis.io/self-hosting-kubernetes-on-your-raspberry-pi/

https://github.com/alexellis/k3sup

https://k3s.io/

https://github.com/k3s-io/k3s

# nom de machine

il est dans `/etc/hostname` et dans `/etc/hosts` mais on peut utiliser `sudo raspi-config` pour modifier ces 2 fichiers d'un sel coup

en profiter pour mettre la mémoire gpu à 16Mb

# définir des adresses IP fixes

Modifier le fichier de configuration suivant :
```
sudo nano /etc/dhcpcd.conf
```
Ajouter ces lignes (ou décommentez les et modifiez-les)

```
interface eth0
static ip_address=192.168.1.200/24
static routers=192.168.1.1
static domain_name_servers=192.168.1.1
```

N’oubliez pas de changer les valeurs par celles correspondantes à votre configuration réseau

Redémarrer le Raspberry Pi
```
sudo reboot
```

en wifi, remplacez eth0 par wlan0

# permettre au maître de se connecter à chaque nœud via SSH sans mot de passe

Sur le maître et dans `home/pi`, créez la clé SSH avec :
```
ssh-keygen
```
Acceptez les valeurs par défaut (chemin par défaut et pas de mot de passe).
Cet outil génère deux clés dans /home/pi/.ssh :
- id _rsa : votre clé privée, conservez-la ici
- id_rsa.pub : la clé publique, vous devez l’envoyer aux nœuds auxquels vous souhaitez accéder sans mot de passe.

Transférez la clé publique sur tous les nœuds :
```
scp /home/pi/.ssh/id_rsa.pub pi@192.168.1.18:/home/pi/master.pub
```
Faites ceci pour chaque nœud que vous souhaitez utiliser.
Ensuite, allez sur chaque nœud et ajoutez la clé dans le fichier authorized_keys.
Ce fichier contient tous les hôtes autorisés à accéder au système via SSH sans mot de passe :
```
ssh pi@192.168.1.18
mkdir .ssh
cat master.pub >> .ssh/authorized_keys
exit
```

