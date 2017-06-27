FROM php:7.0-apache
MAINTAINER Swen van Zanten <swen@troublefree.nl>

RUN apt-get update && apt-get upgrade -yqq
RUN apt-get install -yqq git libmcrypt-dev libpq-dev libcurl4-gnutls-dev libicu-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libxslt-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev openssh-client

# Install PHP extensions
ADD install-php.sh /usr/sbin/install-php.sh
RUN /usr/sbin/install-php.sh
RUN composer global require squizlabs/php_codesniffer && composer global require block8/php-docblock-checker && composer global require phpmd/phpmd

# Install Xdebug extension
RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini

# Install NodeJS
RUN curl https://nodejs.org/dist/v8.1.1/node-v8.1.1-linux-x64.tar.gz -o /tmp/node-latest.tar.gz && \
    tar -C /usr/local --strip-components 1 -xzf /tmp/node-latest.tar.gz &&\
    rm /tmp/node-latest.tar.gz

# Install Java
RUN sh -c 'echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list' \
	&& sh -c 'echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list' \
	&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 \
	&& apt-get update -yqq \
	&& echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
    && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
	&& apt-get install --yes --force-yes oracle-java8-installer

# Install chrome driver
RUN apt-get install -y wget libxss1 libappindicator1 libindicator7 && \
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  	&& echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  	&& apt-get update -qqy \
  	&& apt-get -qqy install google-chrome-stable

# Install selenium
RUN java -version && npm install selenium-standalone -g && selenium-standalone install

WORKDIR /var/www
EXPOSE 80
