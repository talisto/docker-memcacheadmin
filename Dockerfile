FROM php:7.1-alpine

RUN apk --update add autoconf g++ make libtool libmemcached-dev libmemcached libmemcached-libs zlib-dev
RUN apk add cyrus-sasl-dev
RUN pecl install memcached
RUN docker-php-ext-enable memcached

ADD https://github.com/elijaa/phpmemcachedadmin/archive/1.3.0.tar.gz /tmp/phpmemcachedadmin
RUN mkdir -p /var/www
RUN cp -r /tmp/phpmemcachedadmin/phpmemcachedadmin-1.3.0/* /var/www

ENV MEMCACHE_HOST memcache
ENV MEMCACHE_PORT 11211

COPY config.php /var/www/Config/Memcache.php

EXPOSE 9083

CMD ["php", "-S", "0.0.0.0:9083", "-t", "/var/www"]
