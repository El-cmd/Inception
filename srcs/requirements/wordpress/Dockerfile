FROM debian:buster


RUN apt update -y && apt upgrade -y && \
	apt install -y \
	wget \
	php8.3 \
	php8.3-fpm \
	php8.3-mysql \
	mariadb-client && \
	wget https://fr.wordpress.org/wordpress-6.5-fr_FR.tar.gz -P /var/www && \
	cd /var/www && tar -xzf wordpress-6.5-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz && \
	chown -R root:root /var/www/wordpress

EXPOSE 9000