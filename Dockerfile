FROM php:7.1-fpm

RUN apt-get update && apt-get install -y \
        libfreetype6-dev libjpeg62-turbo-dev \
        libmcrypt-dev libpng-dev libbz2-dev \
        libssl-dev autoconf \
        ca-certificates curl g++ libicu-dev

RUN docker-php-ext-install \
        bcmath bz2 exif \
        ftp gd gettext mbstring opcache \
        shmop sockets sysvmsg sysvsem sysvshm \
        zip iconv mcrypt pdo_mysql intl

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN apt-get install -y --no-install-recommends libmagickwand-dev && \
        pecl install imagick-3.4.3 && \
        docker-php-ext-enable imagick

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer
RUN composer global require hirak/prestissimo