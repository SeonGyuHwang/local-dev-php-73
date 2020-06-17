FROM php:7.3-apache
RUN a2enmod rewrite

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y apt-utils

RUN apt-get install -y autoconf
RUN apt-get install -y automake
RUN apt-get install -y libssl-dev
RUN apt-get install -y unzip
RUN apt-get install -y build-essential
RUN apt-get install -y libfreetype6-dev
RUN apt-get install -y libjpeg62-turbo-dev
RUN apt-get install -y libpng-dev
RUN apt-get install -y curl
RUN apt-get install -y libaio1

ADD oracle/instantclient-basiclite-linux.x64-19.3.0.0.0dbru.zip /tmp/
ADD oracle/instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip /tmp/
ADD oracle/instantclient-sqlplus-linux.x64-19.3.0.0.0dbru.zip /tmp/

RUN unzip /tmp/instantclient-basiclite-linux.x64-19.3.0.0.0dbru.zip -d /usr/local/
RUN unzip /tmp/instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip -d /usr/local/
RUN unzip /tmp/instantclient-sqlplus-linux.x64-19.3.0.0.0dbru.zip -d /usr/local/

RUN ln -s /usr/local/instantclient_19_3 /usr/local/instantclient
RUN ln -s /usr/local/instantclient/lib* /usr/lib
RUN ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus

RUN echo 'export LD_LIBRARY_PATH="/usr/local/instantclient"' >> /root/.bashrc
RUN echo 'umask 002' >> /root/.bashrc

RUN docker-php-ext-configure oci8 --with-oci8=instantclient,/usr/local/instantclient
RUN docker-php-ext-install oci8

RUN docker-php-ext-install -j$(nproc) bcmath calendar exif gettext \
	sockets dba mysqli pcntl pdo_mysql shmop sysvmsg sysvsem sysvshm

# URL - https://www.programmersought.com/article/9092921365

 # 1.0.3 Add bz2 extension, read and write bzip2 (.bz2) compressed file
RUN apt-get update && \
apt-get install -y --no-install-recommends libbz2-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) bz2

 # 1.0.4 Add enchant extension, spell check library
RUN apt-get update && \
apt-get install -y --no-install-recommends libenchant-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) enchant

 # 1.0.5 Add GD extension. Image processing
RUN apt-get update && \
apt-get install -y --no-install-recommends libfreetype6-dev libjpeg62-turbo-dev libpng-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
docker-php-ext-install -j$(nproc) gd

 # 1.0.6 Add gmp extension, GMP
RUN apt-get update && \
apt-get install -y --no-install-recommends libgmp-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) gmp

 # 1.0.7 Add soap wddx xmlrpc tidy xsl extension
RUN apt-get update && \
apt-get install -y --no-install-recommends libxml2-dev libtidy-dev libxslt1-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) soap wddx xmlrpc tidy xsl

 # 1.0.8 Add zip extension
RUN apt-get update && \
apt-get install -y --no-install-recommends libzip-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) zip

 # 1.0.9 Increase snmp extension
RUN apt-get update && \
apt-get install -y --no-install-recommends libsnmp-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) snmp

 # 1.0.10 Add pgsql, pdo_pgsql extension
RUN apt-get update && \
apt-get install -y --no-install-recommends libpq-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) pgsql pdo_pgsql

 # 1.0.11 Adding pspell extensions
RUN apt-get update && \
apt-get install -y --no-install-recommends libpspell-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) pspell

 # 1.0.13 Add PDO_Firebird extension
RUN apt-get update && \
apt-get install -y --no-install-recommends firebird-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) pdo_firebird

 # 1.0.14 Add pdo_dblib extension
RUN apt-get update && \
apt-get install -y --no-install-recommends freetds-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-configure pdo_dblib --with-libdir=lib/x86_64-linux-gnu && \
docker-php-ext-install -j$(nproc) pdo_dblib

 # 1.0.15 Add ldap extension
#RUN apt-get update && \
#apt-get install -y --no-install-recommends libldap2-dev && \
#rm -r /var/lib/apt/lists/* && \
#docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu && \
#docker-php-ext-install -j$(nproc) ldap

 # 1.0.16 Adding an imap extension
RUN apt-get update && \
apt-get install -y --no-install-recommends libc-client-dev libkrb5-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
docker-php-ext-install -j$(nproc) imap

 # 1.0.17 Add interbase extension
RUN apt-get update && \
apt-get install -y --no-install-recommends firebird-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) interbase

 # 1.0.18 Add intl extension
RUN apt-get update && \
apt-get install -y --no-install-recommends libicu-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) intl

 # 1.0.20 imagick extension
RUN export CFLAGS="$PHP_CFLAGS" CPPFLAGS="$PHP_CPPFLAGS" LDFLAGS="$PHP_LDFLAGS" && \
apt-get update && \
apt-get install -y --no-install-recommends libmagickwand-dev && \
rm -rf /var/lib/apt/lists/* && \
pecl install imagick-3.4.3 && \
docker-php-ext-enable imagick

 # 1.0.21 Add Memcached extension
RUN apt-get update && \
apt-get install -y --no-install-recommends zlib1g-dev libmemcached-dev && \
rm -r /var/lib/apt/lists/* && \
pecl install memcached && \
docker-php-ext-enable memcached

 # 1.0.22 redis extension
RUN pecl install redis-4.0.1 && docker-php-ext-enable redis

 # 1.0.23 Add opcache extension
RUN docker-php-ext-configure opcache --enable-opcache && docker-php-ext-install opcache

EXPOSE 80
EXPOSE 443
