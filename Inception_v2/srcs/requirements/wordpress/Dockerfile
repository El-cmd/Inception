FROM debian:bullseye

# Installer PHP-FPM et WordPress et créer le repertoire si necessaire
RUN apt-get update && apt-get install -y php-fpm php-mysql curl wget unzip && mkdir -p /var/www/html

# Télécharger et installer WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    rm latest.tar.gz && \
    mv wordpress /var/www/html

# Définir les permissions pour WordPress
RUN chown -R www-data:www-data /var/www/html

# Exposer le port pour PHP-FPM
EXPOSE 9000

# Démarrer PHP-FPM
CMD ["php-fpm", "-F"]
