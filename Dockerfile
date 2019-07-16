FROM alpine:3.8
MAINTAINER Alexandre Dias <alex.jm.dias@gmail.com>

RUN apk --update add \
        php7 \
        php7-bcmath \
        php7-dom \
        php7-ctype \
        php7-curl \
        php7-fileinfo \
        php7-fpm \
        php7-gd \
        php7-iconv \
        php7-intl \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-mysqlnd \
        php7-opcache \
        php7-openssl \
        php7-pdo \
        php7-pdo_mysql \
        php7-pdo_pgsql \
        php7-pdo_sqlite \
        php7-phar \
        php7-posix \
        php7-simplexml \
        php7-session \
        php7-soap \
        php7-tokenizer \
        php7-xml \
        php7-xmlreader \
        php7-xmlwriter \
        php7-zip \
    && apk add --no-cache

RUN apk add php7-xdebug \
    pecl install xdebug \
    echo 'zend_extension=/usr/lib/php7/modules/xdebug.so' >> /etc/php7/php.ini \
    echo 'xdebug.coverage_enable=0' >> /etc/php7/php.ini \
    echo 'xdebug.remote_enable=1' >> /etc/php7/php.ini \
    echo 'xdebug.remote_connect_back=1' >> /etc/php7/php.ini \
    echo 'xdebug.remote_log=/tmp/xdebug.log' >> /etc/php7/php.ini \
    echo 'xdebug.remote_autostart=true' >> /etc/php7/php.ini \
    echo 'xdebug.remote_port=9004' >> /etc/php7/php.ini

COPY ./config/php.ini /etc/php7/conf.d/50-setting.ini
COPY ./config/php-fpm.conf /etc/php7/php-fpm.conf

EXPOSE 9000
EXPOSE 9004

CMD ["php-fpm7", "-F"]
