import redis

rco = redis.Redis(host="localhost", port=6379, db=0)

"""
key = "test:key"
rco.hmset(key, {"T":13, "HR":42})

data = rco.hmget(key, "T")
print(data)
"""
data = rco.keys()
print(data)

import mysql.connector

MYSQL_METAS = {
    "host": "localhost",
    "database": "emoncms",
    "user": "emoncms",
    "password": "emonpiemoncmsmysql2016",
}


connection = mysql.connector.connect(**MYSQL_METAS)
if connection.is_connected():
    db_info = connection.get_server_info()
    message = f'Connected to MySQL Server version {db_info} :-)'
    print(message)


