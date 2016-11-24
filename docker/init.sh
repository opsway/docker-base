#!/bin/bash
source /tmp/env.sh

echo -n "${HTTP_AUTH_USER}:" >> /etc/nginx/htpasswd
openssl passwd -apr1 -salt "$HTTP_AUTH_SALT" "$HTTP_AUTH_PASSWORD" >> /etc/nginx/htpasswd

/usr/bin/mysqld_safe &
sleep 10
mysqladmin -u root password "$MYSQL_PASSWORD"
mysql -u root -p$MYSQL_PASSWORD -e "CREATE DATABASE $MYSQL_DATABASE;"
mysql -u root -p$MYSQL_PASSWORD $MYSQL_DATABASE < /tmp/init.sql
