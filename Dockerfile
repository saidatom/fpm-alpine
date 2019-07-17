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

RUN pecl install xdebug

ADD https://gist.githubusercontent.com/saidatom/11294a8dea523e7cdd10b482cce937fc/raw/39626582a4b76a2266109567e65c1cfd219e11f5/php.ini /etc/php7/conf.d/50-setting.ini
ADD https://gist.githubusercontent.com/saidatom/11294a8dea523e7cdd10b482cce937fc/raw/39626582a4b76a2266109567e65c1cfd219e11f5/php-fpm.conf /etc/php7/php-fpm.conf
ADD https://gist.githubusercontent.com/saidatom/11294a8dea523e7cdd10b482cce937fc/raw/8d4200d75cf06518b49f50bd5ae3ee5b54935afd/xdebug.ini /etc/php7/conf.d/xdebug.ini

EXPOSE 9000
EXPOSE 9001

CMD ["php-fpm7", "-F"]
