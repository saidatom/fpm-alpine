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
        php7-pear \
        php7-dev \
        gcc \
        musl-dev \
        make \
        php7-xdebug \
    && apk add --no-cache

RUN apk add --no-cache php7-pear php7-dev gcc musl-dev make
RUN apk add --no-cache --virtual .build-deps \
        libxml2-dev \
        shadow \
        autoconf \
        g++ \
        make \
    && apk add --no-cache imagemagick-dev imagemagick \
    && pecl install imagick \
    && apk del .build-deps \
    && apk add --no-cache php7-imagick

RUN pecl install xdebug

ADD https://gist.githubusercontent.com/saidatom/11294a8dea523e7cdd10b482cce937fc/raw/ee7cdd19e932a1a75ab28840e2ba309dd5218683/php.ini /etc/php7/conf.d/50-setting.ini
ADD https://gist.githubusercontent.com/saidatom/11294a8dea523e7cdd10b482cce937fc/raw/ee7cdd19e932a1a75ab28840e2ba309dd5218683/php-fpm.conf /etc/php7/php-fpm.conf
ADD https://gist.githubusercontent.com/saidatom/11294a8dea523e7cdd10b482cce937fc/raw/ee7cdd19e932a1a75ab28840e2ba309dd5218683/xdebug.ini /etc/php7/conf.d/xdebug.ini

# workaround for https://github.com/docker-library/php/issues/240
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

RUN apk add --no-cache \
            xvfb \
            # Additionnal dependencies for better rendering
            ttf-freefont \
            fontconfig \
            dbus \
    && \

    # Install wkhtmltopdf from `testing` repository
    apk add qt5-qtbase-dev \
            wkhtmltopdf \
            --no-cache \
            --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
            --allow-untrusted \
    && \

    # Wrapper for xvfb
    mv /usr/bin/wkhtmltopdf /usr/bin/wkhtmltopdf-origin && \
    echo $'#!/usr/bin/env sh\n\
Xvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset & \n\
DISPLAY=:0.0 wkhtmltopdf-origin $@ \n\
killall Xvfb\
' > /usr/bin/wkhtmltopdf && \
    chmod +x /usr/bin/wkhtmltopdf

EXPOSE 9000
EXPOSE 9001

CMD ["php-fpm7", "-F"]
