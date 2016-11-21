FROM php:7.0-fpm

MAINTAINER kurtec photodisorder@gmail.com

WORKDIR /var/dispatch

RUN echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list
RUN curl -s https://www.dotdeb.org/dotdeb.gpg | apt-key add -

#update sorces lists and install tools
RUN apt-get update && apt-get install -y git zlib1g-dev \
#    && apt-get install telnet \
#     && apt-get install -y memcached
     && apt-get install -y php7.0-memcached \
     libxml2-dev \
    php7.0-xdebug

# install php extensions
RUN docker-php-ext-install pdo_mysql zip pcntl dom

RUN echo "extension=/usr/lib/php/20151012/memcached.so" > /usr/local/etc/php/conf.d/memcached.ini \
 && echo "extension=/usr/lib/php/20151012/igbinary.so" > /usr/local/etc/php/conf.d/igbinary.ini \
 && echo "extension=/usr/lib/php/20151012/msgpack.so" > /usr/local/etc/php/conf.d/msgpack.ini \
 && echo "zend_extension=/usr/lib/php/20151012/xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini
# install "composer"
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php -r "if (hash_file('SHA384', 'composer-setup.php') === 'aa96f26c2b67226a324c27919f1eb05f21c248b987e6195cad9690d5c1ff713d53020a02ac8c217dbf90a7eacc9d141d') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && php composer-setup.php && php -r "unlink('composer-setup.php');" && mv composer.phar /usr/local/bin/composer

COPY ./www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./php.ini /usr/local/etc/php/

RUN chown -R www-data:www-data /var/www
RUN chmod -R 777 /var/www

RUN echo 'eval `ssh-agent -s`\nssh-add ~/.ssh/github_rsa' >> /root/.bashrc

#install geopipupdate
RUN apt-get install -y autotools-dev automake libtool build-essential libcurl4-openssl-dev
RUN mkdir /var/geoipupdate \
   && cd /var/geoipupdate \
   && git clone https://github.com/maxmind/geoipupdate . \
   && ./bootstrap \
   && ./configure \
   && make && make install
RUN apt-get purge -y --auto-remove autotools-dev automake libtool build-essential libcurl4-openssl-dev

COPY ./GeoIP.conf /usr/local/etc/GeoIP.conf

COPY ./motd /etc/motd
RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/issue && cat /etc/motd' >> /root/.bashrc



EXPOSE 11211

