FROM ubuntu:latest
MAINTAINER Nikita Chernyi <developer.nikus@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

ADD ./docker/init.sh /tmp/init.sh
ADD ./docker/entrypoint.sh /entrypoint.sh

RUN apt-get -y update && apt-get -y install --no-install-recommends curl mc vim ncdu htop nano nginx-full \
    php7.0-fpm php7.0-cli php7.0-mcrypt php7.0-gd php7.0-intl php7.0-mysql \
    php7.0-curl php7.0-soap php7.0-xml php7.0-zip php7.0-xmlrpc php7.0-mbstring \
    php-pclzip mysql-client mysql-server postfix git-core composer python ssh && \
    curl -sS https://raw.githubusercontent.com/colinmollenhour/modman/master/modman > /usr/local/bin/modman && \
    curl -sS https://files.magerun.net/n98-magerun.phar > /usr/local/bin/n98-magerun.phar && \
    chmod +x /usr/local/bin/modman && \
    chmod +x /usr/local/bin/n98-magerun.phar && \
    chmod +x /tmp/init.sh && \
    chmod +x /entrypoint.sh

COPY ./docker/etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/etc/nginx/conf.d/main.conf /etc/nginx/conf.d/main.conf
COPY ./public/ /var/www/current/

ONBUILD ADD ./docker/env.sh /tmp/env.sh
ONBUILD ADD ./docker/init.sql /tmp/init.sql
ONBUILD ADD ./public /var/www/current/
ONBUILD RUN /tmp/init.sh

EXPOSE 80 443
ENTRYPOINT ["/entrypoint.sh"]
