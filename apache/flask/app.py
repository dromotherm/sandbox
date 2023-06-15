import random
import subprocess
from flask import Flask
import redis

app = Flask(__name__)

rco = redis.Redis(host="localhost", port=6379, db=0)

server_url = "http://emoncms.ddns.net"
server_port = 5000
docker_image = "alexjunk/emoncms:0.0.3"

def exec_shell_command(cmd):
    """execute a shell command"""
    try:
        result_success = subprocess.check_output(cmd, shell=True)
    except subprocess.CalledProcessError as e:
        return f'An error {e} occurred'
    return result_success

def get_free_port():
    """get a random port to create a socket"""
    if rco.scard("ports") == 1011:
        return False
    while True:
        port_nb = random.randint(8080, 9090)
        if not rco.sismember("ports", port_nb):
            rco.sadd("ports", port_nb)
            return str(port_nb)

@app.route("/")
def home():
    content = f'Vous en avez marre d\'excel'
    content = f'{content}<br>Vous n\'êtes pas sur de vouloir développer vos scripts de dataviz sous python'
    content = f'{content}<br>Vous pouvez lancer votre application de dataviz ici :'
    content = f'{content}<br><a href={server_url}/try/start>START APP</a>'
    return content

@app.route("/start")
def start():
    nbp = get_free_port()
    cmd = [f'docker run -d -p{nbp}:80 {docker_image}']
    token = exec_shell_command(cmd)
    short_token = token[:13].decode()
    del_route = f'{server_url}/try/delete/{nbp}/{short_token}'
    app_url = f'{server_url}:{nbp}'
    content = f'BRAVO : on vous a attribué le port {nbp} pour y démarrer une application'
    content = f'{content}<br>'
    content = f'{content}<br>1) Commencez par télécharger des données :'
    content = f'{content}<br><a target=_blank href=http://emoncms.ddns.net/emoncms-bloch-2021.tar.gz>datas collège Marc Bloch</a>'
    content = f'{content}<br>l\'archive se téléchargera dans le dossier téléchargements de votre ordinateur'
    content = f'{content}<br>'
    content = f'{content}<br>2) Lancer ensuite l\'application, créez vous un compte'
    content = f'{content}, injectez l\'archive en allant dans backup > import archive, puis allez dans graph pour les visualiser'
    content = f'{content}<br> ATTENTION LES DATAS SONT VIELLES, IL VOUS FAUDRA REMONTER DANS LE TEMPS'
    content = f'{content}<br><a target=_blank href={app_url}>ouvrir app</a>'
    content = f'{content}<br>'
    content = f'{content}<br>3) Tout ceci est gratuit alors éteignez l\'application avant de partir' 
    content = f'{content}<br><a href={del_route}>supprimer app et rendre le port</a>'
    content = f'{content}<br>'
    content = f'{content}<br>Si vous voulez un accès persistant, contactez nous !'
    content = f'{content}<br><script type="text/javascript">window.onbeforeunload = () => fetch({del_route});</script>'
    return content

@app.route("/list")
def list():
    nb_used_ports = rco.scard("ports")
    cmd = ["docker container ls"]
    containers = exec_shell_command(cmd)
    containers = containers.decode().replace("\n","<br>")
    content = f'Il y a {nb_used_ports} port(s) utilisé(s)'
    content = f'{content}<br>{containers}'
    return content

@app.route("/who")
def who():
    cmd = ['whoami']
    return exec_shell_command(cmd)

@app.route("/clear")
def clear():
    rco.delete("ports")
    cmd = ["docker ps -aq | xargs docker stop | xargs docker rm"]
    exec_shell_command(cmd)
    return 'done'

@app.route("/delete/<port>/<token>")
def delete(port, token):
    rco.srem("ports", port)
    cmd = [f'docker container stop {token}']
    exec_shell_command(cmd)
    cmd = [f'docker container rm {token}']
    exec_shell_command(cmd)
    return 'done'
