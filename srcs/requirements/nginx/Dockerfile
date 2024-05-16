FROM debian:buster

RUN apt update -y \ 
	&& apt upgrade -y \ 
	&& apt install nginx -y

RUN apt install OpenSSL -y

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/0=42/OU=42/CN=vloth.42.fr/UID=vloth"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf etc/nginx/nginx.conf

RUN RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]