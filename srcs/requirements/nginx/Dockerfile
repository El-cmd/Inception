FROM debian:buster

RUN apt update -y \ 
	&& apt upgrade -y \ 
	&& apt install nginx -y

RUN apt install OpenSSL -y

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/0=42/OU=42/CN=vloth.42.fr/UID=vloth"

COPY conf/nginx.conf etc/nginx/nginx.conf

EXPOSE 443
