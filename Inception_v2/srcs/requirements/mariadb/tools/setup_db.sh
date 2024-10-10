#!/bin/bash

# Vérifier si les variables sont définies
if [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$MYSQL_DATABASE" ] || [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_PASSWORD" ]; then
  echo "Les variables d'environnement ne sont pas correctement définies."
  exit 1
fi

# Vérifier et arrêter tout processus MariaDB en cours proprement
if pgrep mysqld > /dev/null
then
    echo "Stopping existing MariaDB process"
    service mariadb stop
    sleep 5  # Attendre quelques secondes pour s'assurer que le service est bien arrêté
fi

# Démarrer le service MySQL/MariaDB
echo "Starting MariaDB service"
service mariadb start

# Ajouter un délai pour s'assurer que MariaDB est complètement démarré
sleep 5

# Vérifier si MariaDB est en cours d'exécution avant de continuer
if ! pgrep mysqld > /dev/null
then
    echo "MariaDB did not start successfully"
    exit 1
fi

# Créer la base de données si elle n'existe pas
echo "Création de la base de données si elle n'existe pas..."
mysql -u root -p"$SQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Créer l'utilisateur SQL s'il n'existe pas
echo "Création de l'utilisateur SQL s'il n'existe pas..."
mysql -u root -p"$SQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Accorder les privilèges à l'utilisateur sur la base de données
echo "Attribution des privilèges à l'utilisateur sur la base de données..."
mysql -u root -p"$SQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"

# Configurer l'utilisateur root pour des connexions distantes
echo "Configuration de l'utilisateur root pour des connexions distantes..."
mysql -u root -p"$SQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$SQL_ROOT_PASSWORD' WITH GRANT OPTION;"

# Rafraîchir les privilèges pour appliquer les modifications
echo "Rafraîchissement des privilèges..."
mysql -u root -p"$SQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

# Arrêter proprement MariaDB avec mysqladmin
echo "Arrêt propre de MariaDB avec mysqladmin..."
mysqladmin -u root -p"$SQL_ROOT_PASSWORD" shutdown

# Attendre quelques secondes pour s'assurer que MariaDB est complètement arrêté
echo "Attendre quelques secondes pour la fermeture complète de MariaDB..."
sleep 5

# Redémarrer MariaDB en mode sûr
echo "Redémarrage de MariaDB avec mysqld_safe..."
exec mysqld_safe &

# Confirmation de la configuration terminée
echo "Configuration de MariaDB terminée."
