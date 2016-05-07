# Use this as a base image
FROM ubuntu:14.04


# Optional: specify the maintainer
MAINTAINER Andres Mendez <amj.desarrollo@gmail.com>


# Run any command on terminal
RUN    apt-get update \
    && apt-get -y install \
        apache2 \
        php5 \
        libapache2-mod-php5 \
        php5-mcrypt \
        php5-json \
        php5-mysql \
        curl \
        git \
        nodejs \
        npm \
        nano \
    && apt-get clean \
    && update-rc.d apache2 defaults \
    && php5enmod mcrypt \
    && a2enmod rewrite \
    && rm -rf /var/www/html \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && ln -s /usr/bin/nodejs /usr/bin/node \
    && npm install -g gulp


WORKDIR /var/www


COPY 000-default.conf /etc/apache2/sites-available/000-default.conf


# Expose necessary ports to the container
EXPOSE 80
EXPOSE 443


CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]