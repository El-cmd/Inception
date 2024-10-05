#!/bin/bash

#demarrer MySQL
service mysql start;

# Attendre que MariaDB soit complètement démarré
sleep 10

#Creation de la table si elle n'existe pas deja avec le nom stocker dans le .env
mysql -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"

#Creation d'un utilisateur avec un mdp qui pourra manipuler la table
mysql -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

#Donner les droits de la table à lutilisateur qui vient detre créer
mysql -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'localhost';"

#Modifacation de lutilisateur root pour lui donner un mdp -> + de securité
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

#Prise en compte des modification des privileges fait juste avant
mysql -e "FLUSH PRIVILEGES;"

#permet d'arreter le server mariadb de maniere securisé
mysqladmin -u root -p"$SQL_ROOT_PASSWORD" shutdown

#script fourni avec mariadb qui permet de demarrer le serveur de maniere securisé
exec mysqld_safe
