""" API for a docker containers application server """
import random
import subprocess
import datetime
import re
from flask import Flask
from flask import render_template
from flask import request
import redis

# pylint: disable=R0914

app = Flask(__name__)

RCO = redis.Redis(host="localhost", port=6379, db=0)

SERVER_NAME = "emoncms.ddns.net"
DOCKER_IMAGE = "emoncms_ssh"
# chemin du fichier apache de configuration des VirtualHosts
APACHE_CONF = "/etc/apache2/sites-available/default-ssl.conf"

def exec_shell_command(cmd):
    """execute a shell command"""
    try:
        result_success = subprocess.check_output(cmd, shell=True)
    except subprocess.CalledProcessError as err:
        return f'An error {err} occurred'
    return result_success

def get_free_port():
    """get a random port to create a socket
    on offre en théorie 1011 ports :-)"""
    if RCO.scard("ports") == 1011:
        return False
    while True:
        port_nb = random.randint(8080, 9090)
        if not RCO.sismember("ports", port_nb):
            RCO.sadd("ports", port_nb)
            return str(port_nb)

def maj_apache_conf(new_conf):
    """met à jour le fichier apache de configuration
    puis relance apache
    """
    with open("apache.conf", "w", encoding="utf-8") as f_p:
        for line in new_conf:
            f_p.write(line)
    cmd = [f'sudo mv apache.conf {APACHE_CONF}']
    exec_shell_command(cmd)
    cmd = ['sudo systemctl reload apache2']
    exec_shell_command(cmd)

def read_apache_conf():
    """retourne le fichier apache de configuration
    sous la forme d'un tableau
    """
    lines = []
    with open(APACHE_CONF, "r", encoding="utf-8") as f_p:
        lines = f_p.readlines()
    return lines


@app.route("/")
def home():
    """home page"""
    lang = request.accept_languages.best_match(['fr', 'en'])
    return render_template('home.html', lang=lang)

@app.route("/start")
def start():
    """start a new container"""
    proto = request.scheme
    container_port = 443 if proto=="https" else 80
    host_port = get_free_port()
    cmd = [f'docker run -d -p{host_port}:{container_port} {DOCKER_IMAGE}']
    long_token = exec_shell_command(cmd)
    token = long_token[:12].decode()
    app_url = f'{proto}://{SERVER_NAME}/{token}'
    lines = read_apache_conf()
    end_balise = -1
    for i, line in enumerate(lines):
        if '</VirtualHost>' in line:
            end_balise = i
            break
    tab = "		"
    lines.insert(end_balise, f'{tab}ProxyPass /{token} {proto}://127.0.0.1:{host_port}\n')
    lines.insert(end_balise, f'{tab}ProxyPassReverse /{token} {proto}://127.0.0.1:{host_port}\n')
    proxy_check_cn_configured = False
    proxy_check_cn_directive = f'{tab}SSLProxyCheckPeerCN off\n'
    proxy_engine_configured = False
    proxy_engine_directive = f'{tab}SSLProxyEngine on\n'
    for i, line in enumerate(lines):
        if "SSLProxyCheckPeerCN" in line:
            proxy_check_cn_configured = True
            if "off" not in line:
                lines[i] = proxy_check_cn_directive
        if "SSLProxyEngine" in line:
            proxy_engine_configured = True
            if "on" not in line:
                lines[i] = proxy_engine_directive
    if not proxy_check_cn_configured:
        lines.insert(end_balise, proxy_check_cn_directive)
    if not proxy_engine_configured:
        lines.insert(end_balise, proxy_engine_directive)
    maj_apache_conf(lines)
    json_datas = {}
    json_datas["token"] = token
    json_datas["port"] = host_port
    json_datas["app_url"] = app_url
    resp = app.make_response(json_datas)
    cookie_life_duration = datetime.datetime.now() + datetime.timedelta(days=30)
    resp.set_cookie('emoncms_token', token, samesite='Lax', secure=True,
                    expires=cookie_life_duration)
    resp.set_cookie('port', host_port, samesite='Lax', secure=True,
                    expires=cookie_life_duration)
    resp.set_cookie('app_url', app_url, samesite='Lax', secure=True,
                    expires=cookie_life_duration)
    return resp

@app.route("/list")
def list_running_containers():
    """list running containers"""
    nb_used_ports = RCO.scard("ports")
    cmd = ["docker container ls"]
    containers = exec_shell_command(cmd)
    containers = containers.decode().replace("\n","<br>")
    content = f'Il y a {nb_used_ports} port(s) utilisé(s)'
    content = f'{content}<br>{containers}'
    return content

@app.route("/check/<token>")
def check(token):
    """given a token, check if container is running"""
    cmd = [f'docker ps | grep {token}']
    return exec_shell_command(cmd)

@app.route("/clear")
def clear():
    """delete all running containers"""
    all_ports = RCO.smembers("ports")
    lines = read_apache_conf()
    suppress_list = []
    tokens = []
    pattern = "ProxyPass /([0-9a-z]{12})"
    motif = re.compile(pattern)
    for i, line in enumerate(lines):
        for port in all_ports:
            if str(port.decode()) in line :
                suppress_list.append(i)
                if "ProxyPass /" in line:
                    result = re.search(motif, line)
                    tokens.append(result.group(1))
    RCO.delete("ports")
    # un peu trop brutal
    #cmd = ["docker ps -aq | xargs docker stop | xargs docker rm"]
    #exec_shell_command(cmd)
    token_string = ""
    for token in tokens:
        token_string = f'{token_string} {token}'
    cmd = [f'docker container stop{token_string}']
    exec_shell_command(cmd)
    cmd = [f'docker container rm{token_string}']
    exec_shell_command(cmd)
    new_conf = []
    for i, line in enumerate(lines):
        if i not in suppress_list:
            new_conf.append(line)
    maj_apache_conf(new_conf)
    return 'done'

@app.route("/delete/<port>/<token>")
def delete(port, token):
    """given a port and a token, delete corresponding container"""
    RCO.srem("ports", port)
    cmd = [f'docker container stop {token}']
    exec_shell_command(cmd)
    cmd = [f'docker container rm {token}']
    exec_shell_command(cmd)
    lines = read_apache_conf()
    suppress_list = []
    for i, line in enumerate(lines):
        if port in line and token in line:
            suppress_list.append(i)
    new_conf = []
    for i, line in enumerate(lines):
        if i not in suppress_list:
            new_conf.append(line)
    maj_apache_conf(new_conf)
    return 'done'
