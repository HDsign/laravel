#!/bin/sh

docker-php-ext-install \
    curl \
    exif \
    gd \
    gettext \
    intl \
    mcrypt \
    mbstring \
    json \
    pdo_mysql \
    pdo_pgsql \
    xmlrpc \
    opcache \
    soap \
    xsl \
    zip

# Download trusted certs 
mkdir -p /etc/ssl/certs && update-ca-certificates

# Install composer
php -r "readfile('https://getcomposer.org/installer');" | php && \
   mv composer.phar /usr/bin/composer && \
   chmod +x /usr/bin/composer
