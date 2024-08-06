FROM php:8.2-fpm AS build

### Install system dependencies
RUN apt-get update -yyq \
    && apt-get install -yyq --no-install-recommends \
        git curl vim nano zip unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

COPY ./app/composer.* /var/www/html/
COPY --from=composer /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN composer install --no-interaction --no-progress --no-suggest --optimize-autoloader

WORKDIR /var/www/html
COPY ./app /var/www/html
RUN ./vendor/bin/phpunit tests/ -vvv --coverage-text


### Could use some help implementing multi-stage builds into a minimal image:
### When naming the previous stage (`FROM php:8.2-fpm as build`) and 
### re-instating the bellow commented out COPY statements leads it to 
### an error starting the php-fpm service.
FROM scratch
COPY --from=build /bin /bin
COPY --from=build /usr /usr
COPY --from=build /usr/local/bin/php /usr/local/bin/php
COPY --from=build /usr/local/php /usr/local/php
COPY --from=build /usr/local/sbin/php-fpm /usr/local/bin/php-fpm
COPY --from=build /usr/bin/composer /usr/bin/composer
COPY --from=build /var/www/html /var/www/html

ARG UID
ARG GID
ARG WEBUSER
ARG WEBGROUP

### Defaults:
ARG WEBUSER=${WEBUSER:-root}
ARG WEBGROUP=${WEBGROUP:-root}
ARG UID=${UID:-1000}
ARG GID=${GID:-1000}

### Create matching user & group to preserve file ownership between host and container:
RUN addgroup --gid ${GID} --system ${WEBGROUP}
RUN adduser --disabled-password --gecos '' --uid ${UID} --ingroup ${WEBGROUP} ${WEBUSER}
RUN chown -R ${WEBUSER}:${WEBGROUP} /var/www/html

### Update PHP-FPM user:
RUN sed -ri -e "s!user = www-data!user = ${WEBUSER}!g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -ri -e "s!group = www-data!group = ${WEBGROUP}!g" /usr/local/etc/php-fpm.d/www.conf

EXPOSE 9000

CMD ["php-fpm", "-F"]
