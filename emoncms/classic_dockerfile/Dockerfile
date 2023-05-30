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
	sudo sed -i "s/^save 900 1/#save 900 1/" /etc/redis/redis.conf; \
	sudo sed -i "s/^save 300 1/#save 300 1/" /etc/redis/redis.conf; \
	sudo sed -i "s/^save 60 1/#save 60 1/" /etc/redis/redis.conf

RUN make mosquitto; \
	make emoncms_www; \
	make sudoers; \
	make apacheconf

ENV SUPERVISOR_PATH=/etc/supervisor/supervisord.conf

RUN ifconfig

RUN echo "[supervisord]\n"\
"[program:apache]\n"\
"command=/usr/sbin/apache2ctl -D FOREGROUND\n"\
"priority=998\n"\
"redirect_stderr=true\n"\
"[program:mariadb]\n"\
"command=mysqld\n" > $SUPERVISOR_PATH

#ENTRYPOINT /usr/bin/supervisord -n -c $SUPERVISOR_PATH
