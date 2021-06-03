.PHONY: investigate

source := https://raw.githubusercontent.com/openenergymonitor/EmonScripts/master/defaults/apache2

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
emoncms_datadir := /var/opt/emoncms

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
	@printf "ErrorLog /var/log/emoncms/apache2-error.log\n" >> emonsd.conf
	@sudo cp emonsd.conf /etc/apache2/conf-available/emonsd.conf
	@sudo a2enconf emonsd.conf
	@echo "virtual host configuration"
	@printf "<VirtualHost *:80>\n" > emoncms.conf
	@printf "    ServerName localhost\n" >> emoncms.conf
	@printf "    ServerAdmin webmaster@localhost\n" >> emoncms.conf
	@printf "    DocumentRoot /var/www/emoncms\n" >> emoncms.conf
	@printf "\n" >> emoncms.conf
	@printf "    # Virtual Host specific error log\n" >> emoncms.conf
	@printf "    ErrorLog /var/log/emoncms/apache2-error.log\n" >> emoncms.conf
	@printf "\n" >> emoncms.conf
	@printf "    <Directory /var/www/emoncms\n" >> emoncms.conf
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
	@sudo chown $(user) /var/www
	@if [ ! -d "/var/www/emoncms" ]; then\
		echo "Installing emoncms core repository with git";\
		cd /var/www && git clone -b $(emoncms_core_branch) $(git_repo[emoncms_core]);\
	fi
	@sudo mkdir $(emoncms_log_location)
	@sudo chown $(user) $(emoncms_log_location)
	@sudo touch $(emoncms_log_location)/emoncms.log
	@sudo chmod 666 $(emoncms_log_location)/emoncms.log

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