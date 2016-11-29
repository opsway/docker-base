#!/bin/bash
source /tmp/env.sh

echo -n "${HTTP_AUTH_USER}:" >> /etc/nginx/htpasswd
openssl passwd -apr1 -salt "$HTTP_AUTH_SALT" "$HTTP_AUTH_PASSWORD" >> /etc/nginx/htpasswd

/usr/bin/mysqld_safe &
echo -e "\033[0;31mSLEEP 60 seconds. Don't worry, all ok, we just need wait mysql server to start.\033[0m"
sleep 60
mysqladmin -u root password "$MYSQL_PASSWORD"
mysql -u root -p$MYSQL_PASSWORD -e "CREATE DATABASE $MYSQL_DATABASE;"
mysql -u root -p$MYSQL_PASSWORD $MYSQL_DATABASE < /tmp/init.sql
mysql -u root -p$MYSQL_PASSWORD -e "use $MYSQL_DATABASE; UPDATE core_config_data SET value='{{base_url}}' where path='web/unsecure/base_url';"
