FROM debian:bullseye

# Installer PHP-FPM et WordPress et créer le repertoire si necessaire
RUN apt-get update && apt-get install -y php7.4-fpm php-mysql php curl wget unzip mariadb-client

# copy the wordpress configuration script to the root directory in the container
COPY ./tools/wp_script.sh /

#rendre .sh executable
RUN  chmod +x wp_script.sh

# Exposer le port pour PHP-FPM
EXPOSE 9000

# Démarrer le script 
ENTRYPOINT [ "./wp_script.sh" ]
