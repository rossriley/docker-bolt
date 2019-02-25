FROM        php:7.2-apache
MAINTAINER  Ross Riley "riley.ross@gmail.com"

RUN apt-get update && apt-get install -y libpq-dev git libpng-dev libjpeg62-turbo-dev libfreetype6-dev wget libxrender1 libfontconfig1 libsqlite3-dev sqlite3 curl git
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
		docker-php-ext-install gd && \
        docker-php-ext-install pdo_sqlite && \
        docker-php-ext-install exif && \
        docker-php-ext-install zip && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*


RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Copy across the local files to the root directory
ADD . /var/www/html/
ADD ./server/apache-vhost.conf /etc/apache2/sites-enabled/000-default.conf
ADD ./server/php-config.ini /usr/local/etc/php/conf.d/php-config.ini
RUN chmod +x /var/www/html/start.sh
RUN cd /var/www/html && composer install

CMD ["/var/www/html/start.sh"]