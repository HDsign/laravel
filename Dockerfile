FROM php:7.0-apache
MAINTAINER hitalos <hitalos@gmail.com>

RUN apt-get update -yqq && apt-get install -yqq git libmcrypt-dev libpq-dev libcurl4-gnutls-dev libicu-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev openssh-client

# Install PHP extensions
ADD install-php.sh /usr/sbin/install-php.sh
RUN /usr/sbin/install-php.sh

# Download and install NodeJS
# ENV NODE_VERSION 8.1.0
# ADD install-node.sh /usr/sbin/install-node.sh
# RUN /usr/sbin/install-node.sh
# RUN npm i -g yarn

WORKDIR /var/www
# CMD php ./artisan serve --port=80 --host=0.0.0.0
# EXPOSE 80
