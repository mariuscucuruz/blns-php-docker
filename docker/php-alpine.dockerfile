FROM php:8.2-fpm-alpine

RUN apk update \
    && apk add --virtual build-deps vim \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

COPY ./app/composer.* /var/www/html/
COPY --from=composer /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN composer install --no-interaction --no-progress --no-suggest --optimize-autoloader

WORKDIR /var/www/html
COPY ./app /var/www/html

RUN ./vendor/bin/phpunit tests/ -vvv --coverage-text

EXPOSE 9000

CMD ["php-fpm", "-F"]
