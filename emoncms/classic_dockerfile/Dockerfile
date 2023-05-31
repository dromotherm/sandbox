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

#RUN wget https://raw.githubusercontent.com/dromotherm/sandbox/master/makefile
COPY makefile .

ENV MYSQL_DATABASE=emoncms
ENV mysql_user=emoncms
ENV mysql_password=emonpiemoncmsmysql2016
ENV emoncms_log_location=/var/log/emoncms

RUN set -eux; \
	sudo apt-get install -y apache2 gettext; \
	sudo sed -i "s/^CustomLog/#CustomLog/" /etc/apache2/conf-available/other-vhosts-access-log.conf; \
	sudo a2enmod rewrite; \
	sudo apt-get install -y mariadb-server mariadb-client; \
	sudo service mysql start; \
	sudo mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"; \
	sudo mysql -e "DELETE FROM mysql.user WHERE User='';"; \
	sudo mysql -e "DROP DATABASE IF EXISTS test;"; \
	sudo mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'; FLUSH PRIVILEGES;"; \
	sudo mysql -e "CREATE DATABASE $MYSQL_DATABASE DEFAULT CHARACTER SET utf8;"; \
	sudo mysql -e "CREATE USER '$mysql_user'@'localhost' IDENTIFIED BY '$mysql_password';"; \
	sudo mysql -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$mysql_user'@'localhost'; flush privileges;"; \
	make php

RUN set -eux; \
	export php_ver=$(php -v | head -n 1 | cut -d " " -f 2 | cut -f1-2 -d"." ); \
	sudo apt-get install -y redis-server; \
	rm -rf phpredis; \
	git clone https://github.com/phpredis/phpredis; \
	cd phpredis && phpize && ./configure && make && sudo make install; \
	printf "extension=redis.so" | sudo tee /etc/php/$php_ver/mods-available/redis.ini 1>&2; \
	sudo phpenmod redis; \
	pip3 install redis; \
	sudo sed -i "s/daemonize yes/daemonize no/" /etc/redis/redis.conf; \
	sudo sed -i "s/^save 900 1/#save 900 1/" /etc/redis/redis.conf; \
	sudo sed -i "s/^save 300 1/#save 300 1/" /etc/redis/redis.conf; \
	sudo sed -i "s/^save 60 1/#save 60 1/" /etc/redis/redis.conf

RUN make mosquitto

ENV www=/var/www
ENV emoncms_datadir=/var/opt/emoncms
ENV openenergymonitor_dir=/opt/openenergymonitor
ENV emoncms_dir=/opt/emoncms
ENV mqtt_user=emonpi
ENV mqtt_password=emonpimqtt2016

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
	echo "www-data ALL=(ALL) NOPASSWD:/sbin/shutdown" | sudo tee /etc/sudoers.d/emoncms-rebootbutton; \
	chmod 0440 /etc/sudoers.d/emoncms-rebootbutton; \
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

ENV SUPERVISOR_PATH=/etc/supervisor/supervisord.conf

RUN ifconfig

RUN echo "[supervisord]\n"\
"[program:apache]\n"\
"command=service apache2 start\n"\
"priority=998\n"\
"redirect_stderr=true\n"\
"[program:mariadb]\n"\
"command=service mysql start\n"\
"[program:redis-server]\n"\
"command=service redis-server start"\
"[program:mosquitto-server]\n"\
"command=service mosquitto start"\
"[program:emoncms_mqtt]\n"\
"command=php /var/www/emoncms/scripts/services/emoncms_mqtt/emoncms_mqtt.php" > $SUPERVISOR_PATH

#ENTRYPOINT /usr/bin/supervisord -n -c $SUPERVISOR_PATH
