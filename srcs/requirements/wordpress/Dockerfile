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

EXPOSE 9000
