# Utiliser Debian Bullseye comme base
FROM debian:bullseye

# Installer MariaDB
RUN apt-get update && apt-get install -y mariadb-server

# Copier le fichier de configuration personnalisé dans le conteneur
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copier le script de setup dans le conteneur
COPY ./tools/setup_db.sh /usr/local/bin/setup_db.sh

RUN chmod +x /usr/local/bin/setup_db.sh

# Exposer le port 3306 pour MariaDB
EXPOSE 3306

#Utiliser ENTRYPOINT pour garantir l'exécution du script à chaque démarrage du conteneur
ENTRYPOINT ["/usr/local/bin/setup_db.sh"]