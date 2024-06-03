FROM debian:buster

RUN apt update -y \ 
	&& apt upgrade -y \ 
	&& apt install nginx -y

RUN mkdir -p /etc/nginx/ssl

RUN apt install openssl -y

RUN openssl req -newkey rsa:2048 -nodes -keyout /etc/nginx/ssl/vloth.42.fr.key -x509 -daysvlot 365 -out /etc/nginx/ssl/vloth.42.fr.crt -subj "/C=FR/ST=75/L=Paris/0=42/O=42/CN=vloth/UID=vloth"

RUN rm /etc/nginx/sites-enabled/default

COPY conf/nginx.conf /etc/nginx/sites-available/my_site.conf
RUN ln -s /etc/nginx/sites-available/my_site.conf /etc/nginx/sites-enabled/my_site.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]	