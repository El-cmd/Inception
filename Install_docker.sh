#!/bin/bash

# Définition des variables
GPG_KEY_URL="https://download.docker.com/linux/ubuntu/gpg"
DOCKER_REPO="https://download.docker.com/linux/ubuntu"
LSB_RELEASE=$(lsb_release -cs)  # Récupère le nom de code de la distribution
ARCH="amd64"

# Ajout de la clé GPG du dépôt Docker
echo "Ajout de la clé GPG pour Docker..."
curl -fsSL $GPG_KEY_URL | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Ajout du dépôt Docker à APT sources
echo "Ajout du dépôt Docker..."
echo "deb [arch=$ARCH signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] $DOCKER_REPO $LSB_RELEASE stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Mise à jour des paquets et installation de Docker
echo "Mise à jour des paquets et installation de Docker..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Vérification de l'installation de Docker
#echo "Vérification de l'installation de Docker..."
#sudo docker run hello-world

# Ajout de l'utilisateur courant au groupe Docker pour permettre l'exécution sans sudo
#echo "Ajout de l'utilisateur $(whoami) au groupe Docker..."
#sudo usermod -aG docker $(whoami)

#echo "Installation terminée. Redémarrez votre ordinateur pour appliquer tous les changements."
