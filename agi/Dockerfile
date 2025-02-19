ARG BUILD_FROM=ubuntu:24.04

FROM $BUILD_FROM

ARG \
    ENV_DIR=/ve

RUN set -eux;\
    apt-get update;\
    apt-get install -y --no-install-recommends tzdata curl iputils-ping net-tools build-essential git;\
    apt-get install -y --no-install-recommends python3 python3-venv python3-pip python3-dev;\
    python3 -m venv $ENV_DIR;\
    $ENV_DIR/bin/pip install --no-cache-dir torch datasets;\
    curl -fsSL https://ollama.com/install.sh | sh

ENV \
    PATH="${ENV_DIR}/bin:$PATH" \
    TZ="Europe/Paris"


