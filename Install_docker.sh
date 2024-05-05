#!/bin/bash

# Définition des variables
GPG_KEY_URL="https://download.docker.com/linux/debian/gpg"
DOCKER_REPO="https://download.docker.com/linux/debian"
LSB_RELEASE=$(lsb_release -cs)  # Récupère le nom de code de la distribution
ARCH="amd64"

# Télécharger et ajouter la clé GPG du dépôt Docker
echo "Ajout de la clé GPG pour Docker..."
curl -fsSL $GPG_KEY_URL | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Ajouter le dépôt Docker à APT sources
echo "Configuration du dépôt Docker pour Debian..."
echo "deb [arch=$ARCH signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] $DOCKER_REPO $LSB_RELEASE stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Mise à jour des paquets et installation de Docker
echo "Mise à jour des paquets et installation de Docker..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Vérifier si Docker est installé correctement
if sudo docker run hello-world; then
    echo "Docker est correctement installé et fonctionnel."
else
    echo "Une erreur s'est produite lors de l'installation de Docker."
fi

# Ajouter l'utilisateur courant au groupe Docker pour permettre l'exécution sans sudo
#echo "Ajout de l'utilisateur $(whoami) au groupe Docker..."
#sudo usermod -aG docker $(whoami)

echo "Installation terminée. Veuillez redémarrer votre ordinateur pour appliquer tous les changements."

# Vérification de l'installation de Docker
#echo "Vérification de l'installation de Docker..."
#sudo docker run hello-world

# Ajout de l'utilisateur courant au groupe Docker pour permettre l'exécution sans sudo
#echo "Ajout de l'utilisateur $(whoami) au groupe Docker..."
#sudo usermod -aG docker $(whoami)

#echo "Installation terminée. Redémarrez votre ordinateur pour appliquer tous les changements."

## Ereur Trouvé 
#Ajout de la clé GPG pour Docker...
#Le fichier « /usr/share/keyrings/docker-archive-keyring.gpg » existe. Faut-il réécrire par-dessus ? (o/N) o
#Ajout du dépôt Docker...
#Mise à jour des paquets et installation de Docker...
#Atteint :1 http://security.debian.org/debian-security bookworm-security InRelease
#Atteint :2 http://deb.debian.org/debian bookworm InRelease                    
#Atteint :3 http://deb.debian.org/debian bookworm-updates InRelease            
#Ign :4 https://download.docker.com/linux/ubuntu bookworm InRelease            
#Err :5 https://download.docker.com/linux/ubuntu bookworm Release
#  404  Not Found [IP : 18.239.94.127 443]
#Lecture des listes de paquets... Fait
#E: Le dépôt https://download.docker.com/linux/ubuntu bookworm Release n'a pas de fichier Release.
#N: Les mises à jour depuis un tel dépôt ne peuvent s'effectuer de manière sécurisée, et sont donc désactivées par défaut.
#N: Voir les pages de manuel d'apt-secure(8) pour la création des dépôts et les détails de configuration d'un utilisateur.
#Lecture des listes de paquets... Fait
#Construction de l'arbre des dépendances... Fait
#Lecture des informations d'état... Fait      
#Aucune version du paquet docker-ce n'est disponible, mais il existe dans la base
#de données. Cela signifie en général que le paquet est manquant, qu'il est devenu obsolète
#ou qu'il n'est disponible que sur une autre source
#
#Aucune version du paquet docker-ce-cli n'est disponible, mais il existe dans la base
#de données. Cela signifie en général que le paquet est manquant, qu'il est devenu obsolète
#ou qu'il n'est disponible que sur une autre source
#
#E: Le paquet « docker-ce » n'a pas de version susceptible d'être installée
#E: Le paquet « docker-ce-cli » n'a pas de version susceptible d'être installée
#E: Impossible de trouver le paquet containerd.io
#E: Impossible de trouver de paquet correspondant à l'expression rationnelle « containerd.io »
#