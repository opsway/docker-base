#!/bin/bash
service mysql start
service php7.0-fpm start
service nginx start

echo -e "\033[0;31mFIXING FILE PERMISSIONS\033[0m\n"
cd /var/www/current
chmod 777 -R .
chown -hR www-data:www-data .
n98-magerun.phar cache:clean && n98-magerun.phar cache:flush

if [[ -z "$1" || $1 == "-d" ]]; then
    while true; do sleep 1000; done
else
    $1
fi
