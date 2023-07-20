FROM ubuntu:20.04

ARG S6_OVERLAY_VERSION=3.1.5.0
ARG S6_DIR=/etc/s6-overlay/s6-rc.d
ARG S6_ARCH=x86_64
ARG S6_SRC=https://github.com/just-containers/s6-overlay/releases/download

ENV TZ="Europe/Paris"

RUN apt-get update && apt-get install -y tzdata xz-utils

ADD $S6_SRC/v$S6_OVERLAY_VERSION/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD $S6_SRC/v$S6_OVERLAY_VERSION/s6-overlay-$S6_ARCH.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-$S6_ARCH.tar.xz

# the build can create itself the s6 file structure
# it is not very nice to read BUT
# the benefit is to offer a synthetic view of the init process
# you understand everything reading ONLY the dockerfile
# the other option is to COPY a prexisting file structure

ARG PRIMOS="apache2 redis mosquitto mariadb"

RUN set -eux;\
	for i in $PRIMOS; do mkdir $S6_DIR/$i; done;\
	for i in $PRIMOS; do mkdir $S6_DIR/$i/dependencies.d; done;\
	for i in $PRIMOS; do touch $S6_DIR/$i/dependencies.d/base; done;\
	for i in $PRIMOS; do touch $S6_DIR/user/contents.d/$i; done;\
	for i in $PRIMOS; do echo "longrun" > $S6_DIR/$i/type; done;\
	for i in $PRIMOS; do echo "#!/command/execlineb -P\n" > $S6_DIR/$i/run; done;\
	echo "/usr/sbin/apache2ctl -DFOREGROUND" >> $S6_DIR/apache2/run;\
	echo "redis-server /etc/redis/redis.conf" >> $S6_DIR/redis/run;\
	echo "mosquitto -c /etc/mosquitto/mosquitto.conf" >> $S6_DIR/mosquitto/run;\
	echo "mysqld" >> $S6_DIR/mariadb/run

#COPY etc/s6-overlay/ /etc/s6-overlay/

RUN \
	apt-get install -y --no-install-recommends --yes apache2; \
	apt-get install -y --no-install-recommends --yes mariadb-server mariadb-client; \
	apt-get install -y --no-install-recommends --yes redis-server; \
	apt-get install -y --no-install-recommends --yes mosquitto libmosquitto-dev

ENTRYPOINT ["/init"]

CMD [ "bash" ]
