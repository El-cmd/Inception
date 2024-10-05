# Utiliser Debian Buster comme base
FROM debian:bullseye

# Installer NGINX et OpenSSL
RUN apt-get update && apt-get install -y nginx openssl

# Créer un répertoire pour les certificats SSL
RUN mkdir -p /etc/nginx/ssl

# Générer un certificat SSL auto-signé
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=IT/CN=localhost"

# Copier la configuration NGINX
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Exposer le port 443
EXPOSE 443

# Démarrer NGINX
CMD ["nginx", "-g", "daemon off;"]
