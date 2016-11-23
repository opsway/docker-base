#!/bin/bash
service mysql start
service php7.0-fpm start
service nginx start

if [[ -z "$1" || $1 == "-d" ]]; then
    while true; do sleep 1000; done
else
    $1
fi
