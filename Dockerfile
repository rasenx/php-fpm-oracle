FROM php:7.2.5-fpm

MAINTAINER Victor Hugo Brito Fernandes <victorhbfernandes@gmail.com>
ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/victorhbfernandes/php-fpm-oracle"


RUN apt-get update && apt-get -y install wget bsdtar libaio1 && \
 wget -qO- https://raw.githubusercontent.com/caffeinalab/php-fpm-oci8/master/oracle/instantclient-basic-linux.x64-12.2.0.1.0.zip | bsdtar -xvf- -C /usr/local && \
 wget -qO- https://raw.githubusercontent.com/caffeinalab/php-fpm-oci8/master/oracle/instantclient-sdk-linux.x64-12.2.0.1.0.zip | bsdtar -xvf-  -C /usr/local && \
 wget -qO- https://raw.githubusercontent.com/caffeinalab/php-fpm-oci8/master/oracle/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip | bsdtar -xvf- -C /usr/local && \
 ln -s /usr/local/instantclient_12_2 /usr/local/instantclient && \
 ln -s /usr/local/instantclient/libclntsh.so.* /usr/local/instantclient/libclntsh.so && \
 ln -s /usr/local/instantclient/lib* /usr/lib && \
 ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus && \
 docker-php-ext-configure oci8 --with-oci8=instantclient,/usr/local/instantclient && \
 docker-php-ext-install oci8

RUN apt-get update && apt-get -qqy install \
   nginx \
   supervisor \
   git \
   zip

RUN rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://phar.phpunit.de/phpunit.phar -o phpunit.phar && \
   chmod +x phpunit.phar && \
   mv phpunit.phar /usr/local/bin/phpunit

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer; \
   chmod +x /usr/local/bin/composer;

RUN rm /etc/nginx/nginx.conf  
COPY ./conf/nginx.conf /etc/nginx/
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir /app
WORKDIR /app
COPY ./src /app

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
