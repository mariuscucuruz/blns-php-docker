# [PHP] Big List of Naughty Strings (Dockerized)

A dockerized version or the PHPimplementation of the Big List of Naughty Strings.

1. [PHP implementation of the Big List of Naughty Strings](https://github.com/mattsparks/blns-php) by [Matt Sparks](https://developmentmatt.com/).

> The *PHP implementation* of the [Big List of Naughty Strings](https://github.com/minimaxir/big-list-of-naughty-strings) by [Max Woolf](https://minimaxir.com/).


2. The infamous [Big List of Naughty Strings](https://github.com/minimaxir/big-list-of-naughty-strings):

> The Big List of Naughty Strings is a list of strings which have a high probability of causing issues when used as user-input data.

3. [Vanilla PHP application](https://github.com/frankjardel/vanilla-php-library) via PHP Composer.


#### Notes

Changing PHP version is trivial, just change the `FROM` value in the `docker/php.dockerfile` file; currently it is set to `8.2-fpm`. For instance, if you want to use PHP 8.1, just change the `FROM` value in the `docker/php.dockerfile` file to `8.1-fpm`.

For this reason, the composer.lock file is Git ignored, so you can use any version of PHP you want.

Optionally, there is a `docker/php-alpine.dockerfile` file, which uses the image with Alpine Linux thus resulting in a smaller image size.


## Prerequisites

Install [Docker](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/engine/install/).


## Usage

```bash
docker compose up -d --build --remove-orphans 

docker exec -it blns-php-app bash -c "composer check"
```

## Contribute

Contributions are very welcome!

- Send a [pull request](https://github.com/mariuscucuruz/blns-php-docker/compare).


## License

MIT
