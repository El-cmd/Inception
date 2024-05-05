# Inception:
## Comprendre Docker et Compose : 


# Docker :
##### les problemes sans Docker : 
- Une dépendance n’est pas compatible avec votre version de logiciel 😅
- Vous possédez déjà la dépendance mais dans une version différente 😑
- Votre dépendance n’existe pas sur votre OS 😓
- Votre dépendance crash au lancement 😮‍💨
##### les avantages de docker :
- pouvoir porter son programme sur n'importe quel machines
- Un docker contient l'application et les dependance de l'application

Docker est un moteur de conteneurisation
Docker est une vm sans noyau (OS, GRAPIQUE RESEAU);

#### Docker HUB :
Docker hub est lapp store de docker qui contient des images qui simplifie la vie 
par exemple si on veut installer un serveur web avec nginx, on install limage de nginx avec un dockerfile qui ressemble à ça 
#### ceci est le  Dockerfile de nginx
```
						FROM		alpine:3.12

						RUN			apk update && apk upgrade && apk add	\
													openssl			\
													nginx			\
													curl			\
													vim				\
													sudo

						RUN			rm -f /etc/nginx/nginx.conf

						COPY		./config/nginx.conf /etc/nginx/nginx.conf
						COPY		scripts/setup_nginx.sh /setup_nginx.sh

						RUN			chmod -R +x /setup_nginx.sh

						EXPOSE		443

						ENTRYPOINT	["sh", "setup_nginx.sh"]
```
Une image docker est un dossier 
###### FROM -> Indique à docker sous quel os tourne votre docker pour debian -> debian::buster

###### RUN -> Permet de lancer des commande, Souvent utiliser pour installer les ressource de base, les dependance, les mise a jour, ou des utilitaire basique comme vim , sudo, curl ect

##### COPY -> Sert a copier un fichier sur la vm depuis le dockerfile: a la racine du fichier en plus du dockerfile peut contenir des fichier a copier sur la vm

##### EXPOSE -> question de reseau, le port ecouté, par exemple si on a deux conteneur, lun avec wordpress et lun avec mariaDB(Base de donné) pour les relier il faudra que les deux conteneur on le meme port ouvert donc expose 3306 pour wd et mdb

###### ENTRYPOINT -> Execute la commande au lancement du container



# Docker-Compose : 
docker Compose est un outil qui sert a gerer les aplications qui utilise plusieurs conteneurs, compose sert à creer un fichier yaml pour definir les service et avec une sseul commande tout mettre en route. On peut aussi utiliser un makefile mettre en place lapplication, il va build les images docker via docker-compose.yml .

###### CONCLUSION : 
Le sujet consiste relier plusieurs images docker, pouvoir les lancer ensemble 
tout ca sans quel perde leur independence. et tout ca grace au docker-compose.

###### Exemple -> 
imaginons une entreprise qui ai besoin dun site internet, elle va creer une image de nginx mais elle a aussi un une badgeuse qui sert a compter les heure. 
Et donc la badegeuse et le site ne communique jamais il faudrait donc les relier.

Il va donc mettre en place un fichier Compose.yml -> YAML qui va donner les instruction a compose pour gerer et relier les differente. ca ressemblerai a ca: 
```
						version: "3"

							services:       # précise les différents services (images) à utiliser 
							nginx:
								build: requirements/website/ 
								env_file: .env          # indique le fichier optionnel contenant l'environnement
								container_name: website # Le nom du container ( doit porter le meme nom que le service d'apres le sujet )
								ports:
								- "80:80"             # le port, détaillé juste en dessous
								restart: always  # Permet de redémarrer automatiquement le container en cas de crash
							nginx:
								build: requirements/intra/
								env_file: .env
								container_name: intra
								ports:
								- "80:80"
								restart: always 
							mariadb:
								container_name: badgeuse
								build: mariadb
								env_file: .env
								restart: always
```
Ce fichier .yml sert a gerer les 3 image: wordpress, nginx et mariadb
un dockerfile doit obligatoirement commencer par FROM et le .yml respecter les norme de la version de Compose

