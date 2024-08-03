FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update -yyq && apt-get install -yyq --no-install-recommends \
        libmcrypt-dev libpng-dev libzip-dev \
        libfreetype-dev libjpeg62-turbo-dev \
        git curl zip unzip \
#    && docker-php-ext-install mbstring exif pcntl bcmath gd \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

COPY ./app /var/www/html
WORKDIR /var/www/html

COPY --from=composer /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1

COPY ./app/composer.* /var/www/html

RUN ./vendor/bin/phpunit tests/


# FROM scratch
# COPY --from=build /bin /bin
# COPY --from=build /usr /usr
# COPY --from=build /usr/local/bin/php /usr/local/bin/php
# COPY --from=build /usr/local/php /usr/local/php
# COPY --from=build /usr/local/sbin/php-fpm /usr/local/sbin/php-fpm
# COPY --from=build /usr/bin/composer /usr/bin/composer
# COPY --from=build /var/www/html /var/www/html

ARG UID
ARG GID
ARG WEBUSER
ARG WEBGROUP

ARG WEBUSER=${WEBUSER:-marius}
ARG WEBGROUP=${WEBGROUP:-marius}
ARG UID=${UID:-1000}
ARG GID=${GID:-1000}

# create matching user and group
# RUN addgroup --gid ${GID} --system ${WEBGROUP}
# RUN adduser --disabled-password --gecos '' --uid ${UID} --ingroup ${WEBGROUP} ${WEBUSER}
# RUN chown -R ${WEBUSER}:${WEBGROUP} .

# update PHP-FPM user
# RUN sed -ri -e "s!user = www-data!user = ${WEBUSER}!g" /usr/local/etc/php-fpm.d/www.conf
# RUN sed -ri -e "s!group = www-data!group = ${WEBGROUP}!g" /usr/local/etc/php-fpm.d/www.conf

EXPOSE 9000

CMD ["php-fpm", "-F"]
