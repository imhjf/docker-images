FROM php:5.6-fpm
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install mysql \
    && pecl install xdebug-2.5.0 \
    && docker-php-ext-enable xdebug
