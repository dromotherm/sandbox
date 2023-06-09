FROM ubuntu:20.04

RUN apt-get update && apt-get upgrade -y; \
    apt-get install -y --no-install-recommends --yes net-tools \
    nano redis-tools mariadb-client \
    python3.8 python3-pip; \
    python3 -m pip install pip --upgrade; \
    python3 -m pip install mysql-connector-python redis \
    pyserial \
    paho-mqtt \
    pymodbus \
    requests

COPY test.py .
