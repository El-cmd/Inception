# Projet Inception

## Description
Ce projet consiste à mettre en place une mini-infrastructure de différents services en utilisant Docker Compose. L'objectif est de créer plusieurs conteneurs Docker qui fonctionnent sur une machine virtuelle.

## Structure du Projet
- `Inception_v1/` : Première version du projet
- `Inception_v2/` : Deuxième version du projet
- `Doc+script/` : Documentation et scripts utilitaires

## Prérequis
- Docker
- Docker Compose
- Une machine virtuelle (de préférence sous Linux)

## Installation
1. Clonez le dépôt
2. Naviguez vers le répertoire souhaité (`Inception_v1` ou `Inception_v2`)
3. Lancez Docker Compose :
```bash
docker-compose up --build
```

## Services
Le projet met en place les services suivants :
- NGINX avec TLSv1.2 ou TLSv1.3
- WordPress + php-fpm
- MariaDB
- Volumes pour la base de données WordPress et les fichiers du site
- Un réseau dédié

## Utilisation
Une fois les conteneurs lancés, vous pouvez accéder à :
- WordPress via HTTPS
- La base de données MariaDB
- Le serveur NGINX

## Maintenance
Les volumes persistent même après l'arrêt des conteneurs, assurant la persistance des données.

## Licence
Ce projet est créé dans le cadre de la formation [École 42].
