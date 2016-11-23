#!/bin/bash
/usr/bin/mysqld_safe &
sleep 10
mysqladmin -u root password "$MYSQL_PASSWORD"
mysql -u root -p$MYSQL_PASSWORD -e "CREATE DATABASE $MYSQL_DATABASE;"
mysql -u root -p$MYSQL_PASSWORD $MYSQL_DATABASE < /tmp/init.sql
