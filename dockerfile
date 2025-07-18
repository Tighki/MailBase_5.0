FROM php:8.2-apache

RUN a2enmod rewrite
RUN \
    apt-get update && \
    apt-get install -y libldap2-dev libicu-dev libpng-dev libjpeg-dev libfreetype6-dev libzip-dev libexif-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install mysqli pdo_mysql pdo ldap intl gd zip exif
