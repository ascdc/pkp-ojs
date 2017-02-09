FROM php:5.6-apache
MAINTAINER ASCDC <ascdc@gmail.com>

RUN apt-get update \
    && apt-get install zlib1g-dev libxml2-dev -y \
    && docker-php-ext-install mysqli mysql zip soap

RUN apt-get install git -y \
    && git config --global url.https://.insteadOf git:// \
    && rm -fr /var/www/html/* \
    && git clone -v --recursive --progress https://github.com/pkp/ojs.git --branch ojs-stable-2_4_8 --single-branch /var/www/html \
    && cd /var/www/html \
    && find . | grep .git | xargs rm -rf \
    && apt-get remove git -y \
    && apt-get autoremove -y \
    && apt-get clean -y

RUN cp config.TEMPLATE.inc.php config.inc.php \
    && mkdir -p /var/www/files/ \
    && chown -R www-data:www-data /var/www/ \