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

### ok Commençont par le docker de nginx

quelque commande -> docker build -t nginx = initialise un conteneur qui se nommera nginx grace a loption -t qui permet de donner un nom a son conteneur.
 docker image ls = visualise tout les conteneur sur votre machine.
 docker run <image-name> = demarre l'image et avec loption -it vous emmene directenment dans le terminal du conteneur loption -d sert la laisse le container actif en fond (sur un autre porcessus).
 docker ps = afficher les contenreur actuellement lancer et avec l'option -a ajoute les conteneur stopper.
 docker system prune = supprime tout les conteneur qui ne son pas en status running
 docker rm <id container> = detruit le conteneur et son contenu
 docker stop <id container> = stop le conteneur
 docker rmi -f [IMAGE_ID] = force la suppression de limage d'un conteneur surtout pour limage exemple hello world


### OpenSSL

OpenSSL est un outil pour generer et gerer des certifcat ssl.
je dois maintenant gerer le certificat ssl grace a openssl que je vais installer sur le containeur de nginx: 

installer openssl: dans le dockerfile de nginx -> 
RUN apt install OpenSSL -y -> install openssl sur le conteneur

Ensuite il faut generer le certificat ssl ->
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/0=42/OU=42/CN=vloth.42.fr/UID=vloth"

Explication pour chaque option ->

`req` : Cette option indique à OpenSSL de lancer la commande de gestion de demande de certificat et de clés de certificat (CSR). Elle peut créer des CSR et aussi générer des certificats.

`-x509` : Cette option indique à `openssl req` de générer un certificat auto-signé plutôt qu'une demande de signature de certificat (CSR). L'utilisation de `-x509` transforme la commande de génération de CSR en une commande de génération de certificat.

`-nodes` : Cela indique que la clé privée ne doit pas être chiffrée. Sans cette option, OpenSSL demanderait un mot de passe pour sécuriser la clé privée.

`-out`: Spécifie le chemin et le nom du fichier où enregistrer le certificat auto-signé généré.

`-keyout` : Spécifie où enregistrer la clé privée générée par cette commande.

`-subj` : Cette option permet de fournir les informations du sujet qui seront utilisées dans le certificat. Elle est utilisée pour éviter l'interaction manuelle lors de la création de certificats ou de CSR. Voici ce que signifient les abréviations et leur contenu :

- **`/C=FR`** : Code du pays (Country Code), ici "FR" pour France.
- **`/ST=IDF`** : État ou province, ici "IDF" pour Île-de-France.
- **`/L=Paris`** : Localité ou ville.
- **`/O=42`** : Organisation, ici "42" qui peut être le nom de l'école ou de l'entreprise.
- **`/OU=42`** : Unité organisationnelle, ici aussi "42", souvent utilisée pour le département ou la division.
- **`/CN=login.42.fr`** : Nom commun, généralement le nom de domaine complet associé au certificat.
- **`/UID=login`** : Identifiant utilisateur, un champ optionnel qui peut être utilisé pour ajouter un identifiant spécifique.

L'utilisation de `-subj` dans cette commande remplit le certificat avec ces détails spécifiques, ce qui est crucial pour l'identification et la sécurité dans les communications cryptées, comme celles utilisées dans HTTPS. Ce certificat peut alors être utilisé par Nginx pour établir des connexions sécurisées SSL/TLS.

il va falloir maintenant configurer nginx avec un fichier de configuration que lon va copier dans l'image grace a la commande COPY conf/nginx.conf etc/nginx/nginx.conf
 'server {
#SSL/TLS configuration nginx
listen 443;
ssl on;
ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;
ssl_certificate /etc/nginx/ssl/inception.crt;
ssl_certificate_key /etc/nginx/ssl/inception.key;
#root, server name and index
server_name vloth.42.fr; # ou localhost
location / {
root /var/www/html;
index index.html index.php;
try_files $uri $uri/ =404;
}
#location ~ \.php$ { # Pour toutes les requetes php
# include snippets/fastcgi-php.conf;
# fastcgi_pass wordpress:9000; # Comment renvoyer les requetes php sur le port 9000
#}
}'  -> le fichier de config







