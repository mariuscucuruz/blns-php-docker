FROM php:8.2-fpm

RUN apt-get update -yyq \
    && apt-get install -yyq --no-install-recommends \
        git curl vim nano zip unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

WORKDIR /var/www/html

COPY ./app /var/www/html
COPY --from=composer /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN composer install --no-interaction --optimize-autoloader

RUN ./vendor/bin/phpunit tests/ -vvv --coverage-text

RUN chmod +x index.php && ./index.php
RUN composer check

EXPOSE 9000

CMD ["php-fpm", "-F"]
