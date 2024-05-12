FROM debian:buster

RUN apt update -y \ 
	&& apt upgrade -y \ 
	&& apt install nginx -y

RUN apt install OpenSSL -y

EXPOSE 443