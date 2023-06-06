FROM ubuntu:20.04
#FROM php:8.0-apache

RUN apt-get update && apt-get upgrade -y && apt-get install tzdata -y

ENV TZ="Europe/Paris"

# others : python3.8-dev python3.8-distutils python3.8-venv ?
# make seems enough so dont install build-essential
RUN apt-get install -y --no-install-recommends --yes python3.8 \
    python3-pip \
    supervisor \
    wget \
    curl \
    git \
    make \
    sed \
    sudo \
    nano \
    iputils-ping \
    net-tools

RUN make --version; \
	mkdir /opt/openenergymonitor

WORKDIR /opt/openenergymonitor

# for backup module quiet install
RUN git clone https://github.com/openenergymonitor/EmonScripts; \
	cp EmonScripts/install/emonsd.config.ini EmonScripts/install/config.ini

#RUN wget https://raw.githubusercontent.com/dromotherm/sandbox/master/makefile
COPY makefile .

ENV MYSQL_DATABASE=emoncms
ENV mysql_user=emoncms
ENV mysql_password=emonpiemoncmsmysql2016
ENV emoncms_log_location=/var/log/emoncms
ENV www=/var/www
ENV emoncms_datadir=/var/opt/emoncms
ENV openenergymonitor_dir=/opt/openenergymonitor
ENV emoncms_dir=/opt/emoncms
ENV mqtt_user=emonpi
ENV mqtt_password=emonpimqtt2016

# install apache, mariadb and php
RUN set -eux; \
	apt-get install -y --no-install-recommends --yes apache2 gettext; \
	sed -i "s/^CustomLog/#CustomLog/" /etc/apache2/conf-available/other-vhosts-access-log.conf; \
	a2enmod rewrite; \
	apt-get install -y --no-install-recommends --yes mariadb-server mariadb-client; \
	service mysql start; \
	mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"; \
	mysql -e "DELETE FROM mysql.user WHERE User='';"; \
	mysql -e "DROP DATABASE IF EXISTS test;"; \
	mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'; FLUSH PRIVILEGES;"; \
	mysql -e "CREATE DATABASE $MYSQL_DATABASE DEFAULT CHARACTER SET utf8;"; \
	mysql -e "CREATE USER '$mysql_user'@'localhost' IDENTIFIED BY '$mysql_password';"; \
	mysql -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$mysql_user'@'localhost'; flush privileges;"

# nothing related to pear/pecl - no package php-pear, no pecl channel-update pecl.php.net
RUN set -eux; \
	apt-get install -y --no-install-recommends --yes php libapache2-mod-php php-mysql; \
	apt-get install -y --no-install-recommends --yes php-gd php-curl php-dev php-common php-mbstring

# install redis and mosquitto
RUN set -eux; \
	export php_ver=$(php -v | head -n 1 | cut -d " " -f 2 | cut -f1-2 -d"." ); \
	apt-get install -y --no-install-recommends --yes redis-server; \
	git clone https://github.com/phpredis/phpredis; \
	cd phpredis && phpize && ./configure && make && make install; \
	printf "extension=redis.so" | tee /etc/php/$php_ver/mods-available/redis.ini 1>&2; \
	phpenmod redis; \
	pip3 install redis; \
	sed -i "s/^save 900 1/#save 900 1/" /etc/redis/redis.conf; \
	sed -i "s/^save 300 1/#save 300 1/" /etc/redis/redis.conf; \
	sed -i "s/^save 60 1/#save 60 1/" /etc/redis/redis.conf; \
	sed -i "s/^daemonize yes/daemonize no/" /etc/redis/redis.conf; \
	cd $openenergymonitor_dir; \
	apt-get install -y --no-install-recommends --yes mosquitto libmosquitto-dev; \
	sed -i "s/^persistence true/persistence false/" /etc/mosquitto/mosquitto.conf; \
	sed -i -n '/allow_anonymous false/!p;$a\allow_anonymous false' /etc/mosquitto/mosquitto.conf; \
	sed -i -n '/password_file \/etc\/mosquitto\/passwd/!p;$a\password_file \/etc\/mosquitto\/passwd' /etc/mosquitto/mosquitto.conf; \
	sed -i -n '/log_type error/!p;$a\log_type error' /etc/mosquitto/mosquitto.conf; \
	touch /etc/mosquitto/passwd; \
	mosquitto_passwd -b /etc/mosquitto/passwd $mqtt_user $mqtt_password; \
	git clone https://github.com/mgdm/Mosquitto-PHP; \
	cd Mosquitto-PHP && phpize && ./configure && make && make install; \
	printf "extension=mosquitto.so" | tee /etc/php/$php_ver/mods-available/mosquitto.ini 1>&2; \
	phpenmod mosquitto

RUN set -eux; \
	cd $www && git clone -b stable https://github.com/emoncms/emoncms.git; \
	mkdir -p $emoncms_log_location; \
	touch $emoncms_log_location/emoncms.log; \
	chmod 666 $emoncms_log_location/emoncms.log; \
	cd $openenergymonitor_dir; \
	echo "emoncms_dir = '$emoncms_dir'\n"\
"openenergymonitor_dir = '$openenergymonitor_dir'\n\n"\
"[sql]\n"\
"server = '127.0.0.1'\n"\
"database = 'emoncms'\n"\
"username = '$mysql_user'\n"\
"password = '$mysql_password'\n"\
"; Skip database setup test - set to false once database has been setup.\n"\
"dbtest   = true\n\n"\
"[redis]\n"\
"enabled = true\n"\
"prefix = ''\n\n"\
"[mqtt]\n"\
"enabled = true\n"\
"user = '$mqtt_user'\n"\
"password = '$mqtt_password'\n\n"\
"[feed]\n"\
"engines_hidden = [0,6,10]\n"\
"redisbuffer[enabled] = true\n"\
"redisbuffer[sleep] = 300\n"\
"phpfina[datadir] = '$emoncms_datadir/phpfina/'\n"\
"phptimeseries[datadir] = '$emoncms_datadir/phptimeseries/'\n\n"\
"[interface]\n"\
"enable_admin_ui = true\n"\
"feedviewpath = 'graph/'\n"\
"favicon = 'favicon_emonpi.png'\n\n"\
"[log]\n"\
"; Log Level: 1=INFO, 2=WARN, 3=ERROR\n"\
"level = 2\n" > settings.ini; \
	cp settings.ini $www/emoncms/settings.ini; \
	mkdir -p $emoncms_datadir/phpfina; \
	chown www-data:root $emoncms_datadir/phpfina; \
	mkdir -p $emoncms_datadir/phpfiwa; \
	chown www-data:root $emoncms_datadir/phpfiwa; \
	mkdir -p $emoncms_datadir/phptimeseries; \
	chown www-data:root $emoncms_datadir/phptimeseries; \
	mkdir -p $emoncms_dir; \
	echo "# ServerName\n"\
"ServerName localhost\n\n"\
"# Default apache2 error log\n"\
"ErrorLog $emoncms_log_location/apache2-error.log\n" > emonsd.conf; \
	cp emonsd.conf /etc/apache2/conf-available/emonsd.conf; \
	a2enconf emonsd.conf; \
	echo "<VirtualHost *:80>\n"\
"    ServerName localhost\n"\
"    ServerAdmin webmaster@localhost\n"\
"    DocumentRoot $www/emoncms\n\n"\
"    # Virtual Host specific error log\n"\
"    ErrorLog $emoncms_log_location/apache2-error.log\n\n"\
"    <Directory $www/emoncms>\n"\
"        Options FollowSymLinks\n"\
"        AllowOverride All\n"\
"        DirectoryIndex index.php\n"\
"        Require all granted\n"\
"    </Directory>\n"\
"</VirtualHost>\n" > emoncms.conf; \
	cp emoncms.conf /etc/apache2/sites-available/emoncms.conf; \
	a2dissite 000-default.conf; \
	a2ensite emoncms

RUN service mysql start; \
	make module name=graph; \
	make module name=dashboard; \
	make symodule name=sync; \
	make symodule name=postprocess; \
	make symodule name=backup

ENV SUPERVISOR_PATH=/etc/supervisor/supervisord.conf

RUN ifconfig

RUN echo "[supervisord]\n"\
"[program:mariadb]\n"\
"priority=995\n"\
"command=mysqld\n"\
"[program:redis-server]\n"\
"priority=996\n"\
"command=redis-server /etc/redis/redis.conf\n"\
"[program:mosquitto-server]\n"\
"priority=997\n"\
"command=mosquitto -c /etc/mosquitto/mosquitto.conf\n"\
"[program:apache]\n"\
"priority=998\n"\
"command=apache2ctl -D FOREGROUND\n"\
"[program:emoncms_mqtt]\n"\
"priority=999\n"\
"command=php $www/emoncms/scripts/services/emoncms_mqtt/emoncms_mqtt.php\n"\
"[program:service-runner]\n"\
"priority=1000\n"\
"command=python3 $www/emoncms/scripts/services/service-runner/service-runner.py\n"\
"[program:feedwriter]\n"\
"priority=1001\n"\
"autorestart=true\n"\
"command=php $www/emoncms/scripts/feedwriter.php\n" > $SUPERVISOR_PATH

EXPOSE 3306

ENTRYPOINT /usr/bin/supervisord -n -c $SUPERVISOR_PATH
