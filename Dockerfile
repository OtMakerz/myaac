FROM php:8.4-apache

# Install required PHP extensions
RUN apt-get update && apt-get install -y \
    libgd-dev \
    libzip-dev \
    curl \
    nodejs \
    npm \
    && docker-php-ext-install -j$(nproc) \
    pdo_mysql \
    gd \
    zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# change UID and GID to 1000
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

WORKDIR /var/www/html

COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Install Node.js dependencies
RUN npm install

# Set permissions
RUN chown -R www-data:www-data /var/www/html