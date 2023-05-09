ARG php_version
ARG composer_version

FROM composer:${composer_version} as composerBase
FROM php:${php_version}-fpm

# Arguments defined in docker-compose.yml
ARG user
ARG uid

# Install system dependencies
RUN apt-get update && apt-get install -y \
	#git
	git \
	#cmd line tool
	curl \
	# PNG images library
	libpng-dev \
	# regular expression library
	libonig-dev \
	# parsiing and manipulating XML
	libxml2-dev \
	# create and extract zip archives
	zip \
	# extract files from zip archives
	unzip \
	vim \
	# a library for Apache Kafka clients
	librdkafka-dev \
	# a library used for Lightweight Directory Access Protocol (LDAP) authentication
	libldap2-dev \
	# a library used for manipulating image data
	libgd-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
	# extension for ldap, if no need then command out
	docker-php-ext-install gd pdo_mysql mbstring exif pcntl bcmath gd sockets ldap

RUN pecl install rdkafka && \
	# install kafka client library for php
	docker-php-ext-enable rdkafka && \
	# install code coverage library for php
	echo 'xdebug.mode=coverage' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Get latest Composer
COPY --from=composerBase /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
	chown -R $user:$user /home/$user

USER $user

COPY config/php/composer.json /home/$user/.composer/composer.json

RUN composer global install

RUN mkdir -p /home/$user/.vscode-server

# Set working directory
WORKDIR /var/www