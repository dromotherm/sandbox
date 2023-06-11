import random
import subprocess
from flask import Flask
import redis

app = Flask(__name__)

rco = redis.Redis(host="localhost", port=6379, db=0)

server_url = "http://192.168.1.25"
server_port = 5000
docker_image = "alexjunk/emoncms:0.0.2" 

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

@app.route("/start")
def start():
    nbp = get_free_port()
    cmd = [f'docker run -d -p{nbp}:80 {docker_image}']
    token = exec_shell_command(cmd)
    short_token = token[:13].decode()
    nb_used_ports = rco.scard("ports")
    del_route = f'{server_url}:{server_port}/delete/{nbp}/{short_token}'
    app_url = f'{server_url}:{nbp}'
    content = f'On vous a attribué le port {nbp} pour y démarrer une application'
    content = f'{content}<br>Il y a {nb_used_ports} ports utilisés dont celui qui vous a été attribué'
    content = f'{content}<br><a target=_blank href={app_url}>ouvrir app</a>'
    content = f'{content}<br><a href={del_route}>supprimer app et rendre le port</a>'
    content = f'{content}<br><script type="text/javascript">window.onbeforeunload = () => fetch({del_route});</script>'
    return content

@app.route("/who")
def who():
    cmd = ['whoami']
    return exec_shell_command(cmd) 

@app.route("/delete/<port>/<token>")
def delete(port, token):
    rco.srem("ports", port)
    cmd = [f'docker container stop {token}']
    exec_shell_command(cmd)
    cmd = [f'docker container rm {token}']
    exec_shell_command(cmd)
    return 'done'
