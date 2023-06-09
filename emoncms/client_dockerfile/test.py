import json
import paho.mqtt.client as mqtt
import mysql.connector
import redis

MQTT_USER = "emonpi"
MQTT_PASSWD = "emonpimqtt2016"
MQTT_HOST = "127.0.0.1"
MQTT_PORT = 1883

MYSQL_METAS = {
    "host": "localhost",
    "database": "emoncms",
    "user": "emoncms",
    "password": "emonpiemoncmsmysql2016",
}

def publish_to_mqtt(node, payload):
    """
    publish to broker
    """
    message = {}
    message["success"] = True
    try:
        mqttc = mqtt.Client()
        mqttc.username_pw_set(MQTT_USER, MQTT_PASSWD)
        mqttc.connect(MQTT_HOST, MQTT_PORT, 60)
    except Exception:
        message["success"] = False
        message["text"] = "Could not connect to MQTT"
    else:
        text = f'Connected to MQTT and sending to node {node}'
        json_payload = json.dumps(payload)

        result = mqttc.publish(f'emon/{node}', json_payload)
        if result[0] != 0 :
            message["success"] = False
            text = f'{text} Error {result}'
        mqttc.disconnect()
        message["text"] = text
    return message

rco = redis.Redis(host="localhost", port=6379, db=0)

connection = mysql.connector.connect(**MYSQL_METAS)
if connection.is_connected():
    db_info = connection.get_server_info()
    message = f'Connected to MySQL Server version {db_info} :-)'
    print(message)

data = rco.keys()
print(data)

message = publish_to_mqtt("test", {"temp": 14})
print(message)
