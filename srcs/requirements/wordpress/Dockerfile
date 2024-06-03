FROM debian:buster


RUN apt update -y && apt upgrade -y && \
	apt install -y \
	wget \
	php7.3 \
	php7.3-fpm \
	php7.3-mysql \
	mariadb-client

RUN	wget https://fr.wordpress.org/wordpress-6.5-fr_FR.tar.gz -P /var/www && \
	cd /var/www && tar -xzf wordpress-6.5-fr_FR.tar.gz && rm wordpress-6.5-fr_FR.tar.gz && \
	chown -R root:root /var/www/wordpress

RUN sed -i 's/;clear_env = yes/clear_env = no/' /etc/php/7.3/fpm/pool.d/www.conf \
	&& sed -i 's/listen = \/run \/php\/php7.3-fpm.sock/listen = 9000/' /etc/php/7.3/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp && mkdir /run/php

EXPOSE 9000

ENTRYPOINT [ "/usr/sbin/php-fpm7.3", "-F" ]
