## PHP FPM Oracle

[![](https://images.microbadger.com/badges/image/victorhbfernandes/php-fpm-oracle-nginx:latest.svg)](https://microbadger.com/images/victorhbfernandes/php-fpm-oracle-nginx:latest "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/victorhbfernandes/php-fpm-oracle-nginx:7.2.5.svg)](https://microbadger.com/images/victorhbfernandes/php-fpm-oracle-nginx:7.2.5 "Get your own version badge on microbadger.com")

### Image Contents:
1. PHP-FPM
1. nginx
1. php-oci8 plugin
1. git
1. composer
1. phpunit
1. supervisord

### Usage instructions:

This image was pre-set to be used on laravel/lumen
Nginx root is set to /app/public

#### Running
docker run example:

```bash
docker run -p 80:80 --name php-oci8 \
           -v /path/to/your/repo:/app \
           -w /app \
           -d victorhbfernandes/php-fpm-oracle-nginx
```

docker-compose example:

```yml
version: '3.5'

services:
    php:
        image: victorhbfernandes/php-fpm-oracle-nginx:latest
        container_name: php
        ports: 
            - "8080:80"
        volumes:
            - /path/to/your/repo/:/app
```

then:
```bash
docker-compose up -d
```

### Thanks
Special thanks to @petronetto for image base
