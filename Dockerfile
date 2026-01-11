FROM php:8.2-apache

# Install required PHP extensions
RUN apt-get update && apt-get install -y \
    libgd-dev \
    libzip-dev \
    && docker-php-ext-install -j$(nproc) \
    pdo_mysql \
    gd \
    zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# change UID and GID to 1000
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

WORKDIR /var/www/html
