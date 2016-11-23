FROM ubuntu:latest
MAINTAINER Nikita Chernyi <developer.nikus@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive
ENV MYSQL_PASSWORD=password
ENV MYSQL_DATABASE=magento

ADD ./files/init_db.sh /tmp/init_db.sh
ADD ./files/init.sql /tmp/init.sql
ADD ./files/entrypoint.sh /entrypoint.sh

RUN apt-get -y update && apt-get -y install --no-install-recommends curl mc vim ncdu htop nginx-full \
    php7.0-fpm php7.0-cli php7.0-mcrypt php7.0-gd php7.0-intl php7.0-mysql \
    php7.0-curl php7.0-soap php7.0-xml php7.0-zip php7.0-xmlrpc php7.0-mbstring \
    php-pclzip mysql-client mysql-server postfix git-core composer && \
    curl -sS https://raw.githubusercontent.com/colinmollenhour/modman/master/modman > /usr/local/bin/modman && \
    curl -sS https://files.magerun.net/n98-magerun.phar > /usr/local/bin/n98-magerun.phar && \
    chmod +x /usr/local/bin/modman && \
    chmod +x /usr/local/bin/n98-magerun.phar && \
    chmod +x /tmp/init_db.sh && \
    chmod +x /entrypoint.sh && \
    /bin/sh /tmp/init_db.sh


EXPOSE 80 443
ENTRYPOINT ["/entrypoint.sh"]
