# Docker base image

> **WARNING**: this image used only for dev and test containers. It's not ready for production usage! You need to change configuration for mysql and nginx if you want use this image on production.

### Usage

```bash
docker run -it -p 80:80 quay.io/opsway/base
```

> **Hint**: if you want run some command in container, just add it at the end of `docker run` (after image name)

### Build image on this base

You need create following structure:

```
./
|
|-- docker/
|         |
|         |-- init.sql - your db dump
|         |-- etc/nginx/conf.d/main.conf - your site configuration
|
|-- public/
|         |
|         |-- index.php - All your app must be in ./public dir
|
|-- Dockerfile
```

And following `Dockerfile`:

```
FROM quay.io/opsway/base
MAINTAINER Your Name <your@email.com>

# Basic auth (configured in /etc/nginx/conf.d/main.conf)
ENV HTTP_AUTH_USER=magento
ENV HTTP_AUTH_PASSWORD=magento
ENV HTTP_AUTH_SALT="$someR@nd0msTR!N6"

# MySQL info (user: root)
ENV MYSQL_PASSWORD=password
ENV MYSQL_DATABASE=magento
```
