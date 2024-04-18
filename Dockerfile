ARG php_version
ARG composer_version

FROM composer:${composer_version} as composerBase
FROM php:${php_version}-fpm

# Arguments defined in docker-compose.yml
ARG user
ARG uid

# Install system dependencies
RUN apt-get update && apt-get install -y \
	git \
	curl \
	libpng-dev \
	libonig-dev \
	libxml2-dev \
	zip \
	unzip \
	vim \
	librdkafka-dev \
	libldap2-dev \
	libgd-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install gd pdo_mysql mbstring exif pcntl bcmath gd sockets ldap

RUN pecl install rdkafka && \
	docker-php-ext-enable rdkafka && \
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