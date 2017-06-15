#!/bin/sh

# Configure extensions
# docker-php-ext-configure gd --with-jpeg-dir=usr/ --with-freetype-dir=usr/ --with-webp-dir=usr/
# docker-php-ext-configure ldap --with-libdir=lib/
# docker-php-ext-configure pdo_dblib --with-libdir=lib/

docker-php-ext-install \
    curl \
    exif \
    gd \
    gettext \
    intl \
    ldap \
    mcrypt \
    mbstring \
    json \
    pdo_mysql \
    pdo_pgsql \
    xmlrpc \
    opcache \
    soap \
    xdebug \
    zip

# Download trusted certs 
mkdir -p /etc/ssl/certs && update-ca-certificates

# Install composer
php -r "readfile('https://getcomposer.org/installer');" | php && \
   mv composer.phar /usr/bin/composer && \
   chmod +x /usr/bin/composer

# apk del $TMP

# Set timezone
# RUN echo America/Maceio > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
