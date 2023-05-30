FROM ubuntu:20.04

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install tzdata -y
ENV TZ="Europe/Paris"

RUN apt-get install -y python3.8 \
    python3-pip \
    python3.8-dev \
    python3.8-distutils \
    python3.8-venv \
    supervisor \
    wget \
    curl \
    git \
    sed \
    sudo \
    nano \
    iputils-ping \
    net-tools

RUN mkdir /opt/openenergymonitor

WORKDIR /opt/openenergymonitor

# for backup module quiet install
RUN git clone https://github.com/openenergymonitor/EmonScripts
RUN cp EmonScripts/install/emonsd.config.ini EmonScripts/install/config.ini

RUN wget https://raw.githubusercontent.com/dromotherm/sandbox/master/makefile

RUN make apache
