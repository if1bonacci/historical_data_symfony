FROM php:8.4-fpm-alpine

RUN apk add --no-cache \
    git \
    curl \
    libpng \
    libjpeg-turbo \
    freetype \
    oniguruma \
    zip \
    unzip \
    icu-libs \
    vim \
    && apk add --no-cache --virtual .build-deps \
        libpng-dev \
        libjpeg-turbo-dev \
        freetype-dev \
        oniguruma-dev \
        icu-dev \
        postgresql-dev \
        autoconf \
        make \
        g++ \
        linux-headers \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        gd \
        intl \
        pdo_pgsql \
        exif \
        pcntl \
        bcmath \
    && pecl channel-update pecl.php.net \
    && pecl install xdebug-3.4.0 \
    && docker-php-ext-enable xdebug \
    && pecl clear-cache \
    && apk del .build-deps

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/symfony
RUN chown -R www-data:www-data /var/www/symfony

COPY docker/php/php.ini /usr/local/etc/php/conf.d/custom.ini