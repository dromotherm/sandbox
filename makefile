# Emoncms stack makefile
# Copyright (C) 2021 Alexandre Cuer <alexandre.cuer at cerema dot fr>

.PHONY: investigate

mysql_user := emoncms
mysql_password := emonpiemoncmsmysql2016
mysql_database := emoncms
mqtt_user := emonpi
mqtt_password := emonpimqtt2016

php_ver := $(shell php -v | head -n 1 | cut -d " " -f 2 | cut -f1-2 -d"." )
user := $(shell id -u -n)
git_repo[emoncms_core] := https://github.com/emoncms/emoncms.git
emoncms_core_branch := stable
emoncms_log_location := /var/log/emoncms
www := /var/www
emoncms_www := $(www)/emoncms
emoncms_datadir := /var/opt/emoncms
openenergymonitor_dir := /opt/openenergymonitor
emoncms_dir := /opt/emoncms

service_dir := /etc/systemd/system
here := $(shell pwd)

osupdate:
	@echo "apt-get update"
	@sudo apt-get update -y
	@echo "apt-get upgrade"
	@sudo apt-get upgrade -y
	@echo "apt-get dist-upgrade"
	@sudo apt-get dist-upgrade -y
	@echo "apt-get clean"
	@sudo apt-get clean
	@sudo apt --fix-broken install
	@sudo apt-get install -y git build-essential python3-pip python3-dev

investigate:
	@echo "php version : $(php_ver)"
	@echo "TO INSTALL THE STACK:"
	@echo "make apache"
	@echo "make mysql"
	@echo "make php"
	@echo "make redis"
	@echo "make mosquitto"
	@echo "NOTA : always run make redis or make mosquitto AFTER make php !!"
	@echo "make emoncms"
	@echo "make feedwriter"
	@echo "make service-runner"

apache:
	@sudo apt-get install -y apache2 gettext
	@sudo sed -i "s/^CustomLog/#CustomLog/" /etc/apache2/conf-available/other-vhosts-access-log.conf
	@echo "Enabling apache mod rewrite"
	@sudo a2enmod rewrite
	@echo "Creating default apache2 configuration"
	@printf "# ServerName\n" > emonsd.conf
	@printf "ServerName localhost\n" >> emonsd.conf
	@printf "\n" >> emonsd.conf
	@printf "# Default apache2 error log\n" >> emonsd.conf
	@printf "ErrorLog $(emoncms_log_location)/apache2-error.log\n" >> emonsd.conf
	@sudo cp emonsd.conf /etc/apache2/conf-available/emonsd.conf
	@sudo a2enconf emonsd.conf
	@echo "virtual host configuration"
	@printf "<VirtualHost *:80>\n" > emoncms.conf
	@printf "    ServerName localhost\n" >> emoncms.conf
	@printf "    ServerAdmin webmaster@localhost\n" >> emoncms.conf
	@printf "    DocumentRoot $(emoncms_www)\n" >> emoncms.conf
	@printf "\n" >> emoncms.conf
	@printf "    # Virtual Host specific error log\n" >> emoncms.conf
	@printf "    ErrorLog $(emoncms_log_location)/apache2-error.log\n" >> emoncms.conf
	@printf "\n" >> emoncms.conf
	@printf "    <Directory $(emoncms_www)>\n" >> emoncms.conf
	@printf "        Options FollowSymLinks\n" >> emoncms.conf
	@printf "        AllowOverride All\n" >> emoncms.conf
	@printf "        DirectoryIndex index.php\n" >> emoncms.conf
	@printf "        Order allow,deny\n" >> emoncms.conf
	@printf "        Allow from all\n" >> emoncms.conf
	@printf "    </Directory>\n" >> emoncms.conf
	@printf "</VirtualHost>\n" >> emoncms.conf
	@sudo cp emoncms.conf /etc/apache2/sites-available/emoncms.conf
	@sudo a2dissite 000-default.conf
	@sudo a2ensite emoncms
	@echo "restarting apache"
	@sudo systemctl restart apache2

emoncms:
	@sudo chown $(user) $(www)
	@if [ ! -d $(emoncms_www) ]; then\
		echo "Installing emoncms core repository with git";\
		cd $(www) && git clone -b $(emoncms_core_branch) $(git_repo[emoncms_core]);\
	fi
	@echo "creating log file"
	@sudo mkdir -p $(emoncms_log_location)
	@sudo chown $(user) $(emoncms_log_location)
	@sudo touch $(emoncms_log_location)/emoncms.log
	@sudo chmod 666 $(emoncms_log_location)/emoncms.log
	@echo "creating settings.ini for emoncms"
	@printf "emoncms_dir = '$(emoncms_dir)'\n" > settings.ini
	@printf "openenergymonitor_dir = '$(openenergymonitor_dir)'\n" >> settings.ini
	@printf "\n" >> settings.ini
	@printf "[sql]\n" >> settings.ini
	@printf "server = '127.0.0.1'\n" >> settings.ini
	@printf "database = 'emoncms'\n" >> settings.ini
	@printf "username = '$(mysql_user)'\n" >> settings.ini
	@printf "password = '$(mysql_password)'\n" >> settings.ini
	@printf "; Skip database setup test - set to false once database has been setup.\n" >> settings.ini
	@printf "dbtest   = true\n" >> settings.ini
	@printf "\n" >> settings.ini
	@printf "[redis]\n" >> settings.ini
	@printf "enabled = true\n" >> settings.ini
	@printf "prefix = ''\n" >> settings.ini
	@printf "\n" >> settings.ini
	@printf "[mqtt]\n" >> settings.ini
	@printf "enabled = true\n" >> settings.ini
	@printf "user = '$(mqtt_user)'\n" >> settings.ini
	@printf "password = '$(mqtt_password)'\n" >> settings.ini
	@printf "\n" >> settings.ini
	@printf "[feed]\n" >> settings.ini
	@printf "engines_hidden = [0,6,10]\n" >> settings.ini
	@printf "redisbuffer[enabled] = true\n" >> settings.ini
	@printf "redisbuffer[sleep] = 300\n" >> settings.ini
	@printf "phpfina[datadir] = '$(emoncms_datadir)/phpfina/'\n" >> settings.ini
	@printf "phptimeseries[datadir] = '$(emoncms_datadir)/phptimeseries/'\n" >> settings.ini
	@printf "\n" >> settings.ini
	@printf "[interface]\n" >> settings.ini
	@printf "enable_admin_ui = true\n" >> settings.ini
	@printf "feedviewpath = 'graph/'\n" >> settings.ini
	@printf "favicon = 'favicon_emonpi.png'\n" >> settings.ini
	@printf "\n" >> settings.ini
	@printf "[log]\n" >> settings.ini
	@printf "; Log Level: 1=INFO, 2=WARN, 3=ERROR\n" >> settings.ini
	@printf "level = 2\n" >> settings.ini
	@if [ ! -f "$(emoncms_www)/settings.ini" ]; then\
		echo "Installing default emoncms settings.ini";\
		cp settings.ini $(emoncms_www)/settings.ini;\
	fi
	@echo "creating data directories for emoncms feed engines"
	@sudo mkdir -p $(emoncms_datadir)/phpfina
	@sudo chown www-data:root $(emoncms_datadir)/phpfina
	@sudo mkdir -p $(emoncms_datadir)/phpfiwa
	@sudo chown www-data:root $(emoncms_datadir)/phpfiwa
	@sudo mkdir -p $(emoncms_datadir)/phptimeseries
	@sudo chown www-data:root $(emoncms_datadir)/phptimeseries
	@echo "creating $(emoncms_dir) directory"
	@sudo mkdir -p $(emoncms_dir)
	@sudo chown $(user) $(emoncms_dir)

sudoers:
	@echo "enabling shutdown for www-data"
	@echo "www-data ALL=(ALL) NOPASSWD:/sbin/shutdown" | sudo tee /etc/sudoers.d/emoncms-rebootbutton
	@sudo chmod 0440 /etc/sudoers.d/emoncms-rebootbutton

feedwriter:
	@echo "creating log file for emoncms"
	@sudo mkdir -p $(emoncms_log_location)
	@sudo chown $(user) $(emoncms_log_location)
	@sudo touch $(emoncms_log_location)/emoncms.log
	@sudo chmod 666 $(emoncms_log_location)/emoncms.log
	@echo "creating feedwriter.service"
	@printf "[Unit]\n" > feedwriter.service
	@printf "Description=Emoncms feedwriter script\n" >> feedwriter.service
	@printf "Wants=mysql.service redis-server.service\n" >> feedwriter.service
	@printf "After=mysql.service redis-server.service\n" >> feedwriter.service
	@printf "\n" >> feedwriter.service
	@printf "[Service]\n" >> feedwriter.service
	@printf "Type=idle\n" >> feedwriter.service
	@printf "ExecStart=/usr/bin/php $(emoncms_www)/scripts/feedwriter.php\n" >> feedwriter.service
	@printf "PermissionsStartOnly=true\n" >> feedwriter.service
	@printf "Restart=on-failure\n" >> feedwriter.service
	@printf "RestartSec=60\n" >> feedwriter.service
	@printf "SyslogIdentifier=feedwriter\n" >> feedwriter.service
	@printf "\n" >> feedwriter.service
	@printf "[Install]\n" >> feedwriter.service
	@printf "WantedBy=multi-user.target\n" >> feedwriter.service
	@echo "creating the symlinks"
	@sudo ln -sf $(here)/feedwriter.service $(service_dir)
	@echo "enabling the feedwriter service"
	@sudo systemctl enable feedwriter.service
	@sudo systemctl restart feedwriter.service

service-runner:
	@echo "creating service-runner service file"
	@printf "[Unit]\n" > service-runner.service
	@printf "Description=Emoncms service-runner Input Script\n" >> service-runner.service
	@printf "Wants=redis-server.service\n" >> service-runner.service
	@printf "After=redis-server.service\n" >> service-runner.service
	@printf "StartLimitIntervalSec=5\n" >> service-runner.service
	@printf "\n" >> service-runner.service
	@printf "[Service]\n" >> service-runner.service
	@printf "Type=simple\n" >> service-runner.service
	@printf "ExecStart=/usr/bin/python3 $(emoncms_www)/scripts/services/service-runner/service-runner.py\n" >> service-runner.service
	@printf "User=$(user)\n" >> service-runner.service
	@printf "Restart=always\n" >> service-runner.service
	@printf "RestartSec=30s\n" >> service-runner.service
	@printf "SyslogIdentifier=service-runner\n" >> service-runner.service
	@printf "\n" >> service-runner.service
	@printf "[Install]\n" >> service-runner.service
	@printf "WantedBy=multi-user.target\n" >> service-runner.service
	@echo "creating the symlinks"
	@sudo ln -sf $(here)/service-runner.service $(service_dir)
	@echo "enabling the service-runner service"
	@sudo systemctl enable service-runner.service
	@sudo systemctl restart service-runner.service

emoncms_mqtt:
	@echo "creating log file for emoncms"
	@sudo mkdir -p $(emoncms_log_location)
	@sudo chown $(user) $(emoncms_log_location)
	@sudo touch $(emoncms_log_location)/emoncms.log
	@sudo chmod 666 $(emoncms_log_location)/emoncms.log
	@echo "creating emoncms_mqtt service file"
	@printf "[Unit]\n" >> emoncms_mqtt.service
	@printf "Description=Emoncms emoncms_mqtt script\n" >> emoncms_mqtt.service
	@printf "Wants=mosquitto.service mysql.service redis-server.service\n" >> emoncms_mqtt.service
	@printf "After=mosquitto.service mysql.service redis-server.service\n" >> emoncms_mqtt.service
	@printf "\n" >> emoncms_mqtt.service
	@printf "[Service]\n" >> emoncms_mqtt.service
	@printf "Type=idle\n" >> emoncms_mqtt.service
	@printf "ExecStart=/usr/bin/php $(emoncms_www)/scripts/services/emoncms_mqtt/emoncms_mqtt.php\n" >> emoncms_mqtt.service
	@printf "PermissionsStartOnly=true\n" >> emoncms_mqtt.service
	@printf "Restart=on-failure\n" >> emoncms_mqtt.service
	@printf "RestartSec=60\n" >> emoncms_mqtt.service
	@printf "SyslogIdentifier=emoncms_mqtt\n" >> emoncms_mqtt.service
	@printf "\n" >> emoncms_mqtt.service
	@printf "[Install]\n" >> emoncms_mqtt.service
	@printf "WantedBy=multi-user.target\n" >> emoncms_mqtt.service
	@echo "creating the symlinks"
	@sudo ln -sf $(here)/emoncms_mqtt.service $(service_dir)
	@echo "enabling the emoncms_mqtt service"
	@sudo systemctl enable emoncms_mqtt.service
	@sudo systemctl restart emoncms_mqtt.service

mysql:
	@echo "Installing the Mariadb server (MYSQL)"
	@sudo apt-get install -y mariadb-server mariadb-client
	@echo "1 - Secure MYSQL"
	@sudo mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
	@sudo mysql -e "DELETE FROM mysql.user WHERE User='';"
	@sudo mysql -e "DROP DATABASE IF EXISTS test;"
	@sudo mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'; FLUSH PRIVILEGES;"
	@echo "2 - Create $(mysql_database) database"
	@sudo mysql -e "CREATE DATABASE $(mysql_database) DEFAULT CHARACTER SET utf8;"
	@echo "3 - Add user:$(mysql_user) and assign to database:$(mysql_database)"
	@sudo mysql -e "CREATE USER '$(mysql_user)'@'localhost' IDENTIFIED BY '$(mysql_password)';"
	@sudo mysql -e "GRANT ALL ON $(mysql_database).* TO '$(mysql_user)'@'localhost'; flush privileges;"

php:
	@echo "Installing PHP"
	@sudo apt-get install -y php
	@sudo apt-get install -y libapache2-mod-php
	@sudo apt-get install -y php-mysql
	@sudo apt-get install -y php-gd php-curl php-pear php-dev php-common php-mbstring
	@sudo pecl channel-update pecl.php.net

redis:
	@echo "Installing redis server"
	@sudo apt-get install -y redis-server
	@echo "installing PHPRedis"
	@sudo pecl install redis
	@printf "extension=redis.so" | sudo tee /etc/php/$(php_ver)/mods-available/redis.ini 1>&2
	@sudo phpenmod redis
	@echo "installing redis for python"
	@pip3 install redis
	@echo "disabling redis persistance"
	@sudo sed -i "s/^save 900 1/#save 900 1/" /etc/redis/redis.conf
	@sudo sed -i "s/^save 300 1/#save 300 1/" /etc/redis/redis.conf
	@sudo sed -i "s/^save 60 1/#save 60 1/" /etc/redis/redis.conf
	@sudo systemctl restart redis-server

mosquitto:
	@echo "Installing mosquitto server"
	@sudo apt-get install -y mosquitto
	@sudo apt-get install -y libmosquitto-dev
	@echo "disabling mosquitto persistance"
	@sudo sed -i "s/^persistence true/persistence false/" /etc/mosquitto/mosquitto.conf
	@echo "append line: allow_anonymous false"
	@sudo sed -i -n '/allow_anonymous false/!p;$$a\allow_anonymous false' /etc/mosquitto/mosquitto.conf
	@echo "append line: password_file /etc/mosquitto/passwd"
	@sudo sed -i -n '/password_file \/etc\/mosquitto\/passwd/!p;$$a\password_file \/etc\/mosquitto\/passwd' /etc/mosquitto/mosquitto.conf
	@echo "append line: log_type error"
	@sudo sed -i -n '/log_type error/!p;$$a\log_type error' /etc/mosquitto/mosquitto.conf
	@echo "Create mosquitto password file"
	@sudo touch /etc/mosquitto/passwd
	@sudo mosquitto_passwd -b /etc/mosquitto/passwd $(mqtt_user) $(mqtt_password)
	@echo "installing PHP mosquitto client"
	@sudo apt-get install -y libmosquitto-dev
	@sudo pecl install Mosquitto-beta
	@echo "Add mosquitto to php mods available"
	@printf "extension=mosquitto.so" | sudo tee /etc/php/$(php_ver)/mods-available/mosquitto.ini 1>&2
	@sudo phpenmod mosquitto

module:
	@printf "<?php\n" > emoncmsdbupdate.php
	@printf "%sapplychanges = true;\n" $$ >> emoncmsdbupdate.php
	@printf "define('EMONCMS_EXEC', 1);\n" >> emoncmsdbupdate.php
	@printf "chdir('/var/www/emoncms');\n" >> emoncmsdbupdate.php
	@printf "require 'process_settings.php';\n" >> emoncmsdbupdate.php
	@printf "require 'core.php';\n" >> emoncmsdbupdate.php
	@printf "%smysqli = @new mysqli(\n" $$ >> emoncmsdbupdate.php
	@printf "    %ssettings['sql']['server'],\n" $$ >> emoncmsdbupdate.php
	@printf "    %ssettings['sql']['username'],\n" $$ >> emoncmsdbupdate.php
	@printf "    %ssettings['sql']['password'],\n" $$ >> emoncmsdbupdate.php
	@printf "    %ssettings['sql']['database'],\n" $$ >> emoncmsdbupdate.php
	@printf "    %ssettings['sql']['port']\n" $$ >> emoncmsdbupdate.php
	@printf ");\n" >> emoncmsdbupdate.php
	@printf "require_once 'Lib/dbschemasetup.php';\n" >> emoncmsdbupdate.php
	@printf "print json_encode(db_schema_setup(%smysqli,load_db_schema(),%sapplychanges)).'%s';" $$ $$ "\n" >> emoncmsdbupdate.php
	@if [ ! -d "$(emoncms_www)/Modules/$(name)" ]; then\
		echo "Installing module $(name)";\
		cd $(emoncms_www)/Modules && git clone -b stable http://github.com/emoncms/$(name);\
	fi
	@echo "update emoncms database";
	@php emoncmsdbupdate.php
