FROM        ubuntu:16.04
MAINTAINER  Ross Riley "riley.ross@gmail.com"

# Install nginx
ENV HOME /root
RUN apt-get update && apt-get install -y nginx supervisor curl git
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.utf-8"' > /etc/default/locale
RUN dpkg-reconfigure locales

# Install PHP7 and modules along with composer binary
RUN apt-get -y install php7.0-fpm php7.0-pgsql php7.0-mcrypt php7.0-curl php7.0-gd php7.0-json php7.0-cli php-ssh2 php7.0-sqlite
RUN sed -i -e "s/short_open_tag = Off/short_open_tag = On/g" /etc/php/7.0/fpm/php.ini
RUN sed -i -e "s/post_max_size = 8M/post_max_size = 20M/g" /etc/php/7.0/fpm/php.ini
RUN sed -i -e "s/upload_max_filesize = 2M/upload_max_filesize = 20M/g" /etc/php/7.0/fpm/php.ini
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Configure nginx for PHP websites
RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php/7.0/fpm/php.ini
RUN echo "max_input_vars = 10000;" >> /etc/php/7.0/fpm/php.ini
RUN echo "date.timezone = Europe/London;" >> etc/php/7.0/fpm/php.ini

# Setup supervisor
ADD supervisor/nginx.conf /etc/supervisor/conf.d/
ADD supervisor/php.conf /etc/supervisor/conf.d/
ADD supervisor/user.conf /etc/supervisor/conf.d/

# Disallow key checking
RUN echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config


# Adds the default server to nginx config
ADD config/nginx.conf /etc/nginx/sites-available/default

# Internal Port Expose
EXPOSE 80 443

ADD ./ /var/www/

RUN chmod +x /var/www/start.sh
RUN cd /var/www/ && composer update
RUN chmod -R 0777 /var/www/app
RUN cd /var/www/ && vendor/bin/nut database:update
RUN cd /var/www/ && vendor/bin/nut user:add admin Admin admin@bolt.cm password root
RUN ln -sf /var/www/vendor/bolt/bolt/theme/base-2014 /var/www/public/theme/base-2014
RUN ln -sf /var/www/vendor/bolt/bolt/theme /var/www/theme

CMD ["/usr/bin/supervisord", "-n"]
