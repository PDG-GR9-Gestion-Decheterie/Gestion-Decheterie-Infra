# Gestion-Decheterie-Infra

## Rapport

### Description du projet

#### Objectifs

L'objectif de ce projet est de créer un système de base de données dédié à la gestion des déchèteries de Suisse.

Le but principal est de fournir un outil qui simplifiera la gestion des déchèteries nationales. Cette base de données permettra un suivi précis des informations essentielles.

Le projet vise à accroître l'efficacité opérationnelle des déchèteries en offrant un système centralisé pour la gestion du personnel, des équipements, et des flux de déchets. Il contribuera ainsi à une meilleure organisation des activités de collecte et de gestion des déchets, tout en facilitant la traçabilité.

#### Exigences fonctionnelles

##### Besoins fonctionnels - Données

Chaque déchèterie possède des contenants, des employés, une adresse et des ramassages qui ont été/seront effectués dans celle-ci.

- Un employé possède un nom, prénom, une date de naissance, un numéro de téléphone, une adresse, date de début contrat, une fonction, un supérieur. Chaque employé est affecté à une déchèterie et possède un login pour se connecter à l’application.
- Une adresse est décrite par une rue et numéro, un code postal, une ville et un pays
- Il y a comme fonction : Responsable, Secrétaire, Chauffeur, Employé.
- Si sa fonction est chauffeur, nous pouvons connaître son type de permis (B, C).

Une déchèterie principale en plus d’avoir les mêmes attributs qu’une déchèterie possède des moyens de transport des déchets (véhicules).

Les contenants sont soit des bennes, des palettes, des grandes caisses ou des big bag et possède un type de déchets contenu.

- Les bennes et les grandes caisses possèdent une capacité maximale (en litre).
- Les bennes possèdent une couleur
- Les big bag ont une taille : petite, moyenne ou grande.
- Les palettes possèdent un nombre de cadres (entre 0 et 4).

Les moyens de transport sont soit des camions, soit des camionnettes avec ou sans remorque et possèdent un numéro d’immatriculation, année de fabrication, date de la dernière expertise ainsi qu’une consommation de carburant.

- Le camion peut seulement transporter des bennes
- La camionnette peut transporter tous les autres types de contenant (palettes, grandes caisses et big bag).

Les différents types de déchets possibles sont :

- Papier
- Carton
- Flaconnage
- Encombrants
- Déchets verts
- Inertes
- Ferraille
- Pet
- Alu
- Fer blanc
- Verre
- Bois
- Appareils électroniques
- Appareils électriques
- Déchets spéciaux

Chaque type de déchets est associé à un contenant en fonction de la manière dont il est stocké sur place.

##### Besoins fonctionnels - Roles

- Un employé à la capacité de faire une demande de ramassage, d’un type de déchet donné, à la déchèterie principale qui doit accepter ou refuser. Si acceptée, la déchèterie principale pourra ensuite affecter un chauffeur ainsi qu’un véhicule.
- Les employés d’une déchèterie pourront consulter tous les ramassages présent et futur prévus.
- Les employés peuvent consulter leur profil avec leur information leur concernant.
- Le responsable, lui, aura accès à tout l’historique des ramassages passés, présents, futurs.
- Un responsable ou un secrétaire peut modifier, ajouter ou supprimer sans restriction des ramassages. Y attribuer un chauffeur, accepter ou refuser un ramassage, y renseigner le poids, etc.
- Un responsable peut consulter toutes les information concernant les employés sauf leur mot de passe.
- Un secrétaire ou un chauffeur ne peut que travailler pour une déchèterie principale.

##### Besoins fonctionnels - Connexion

- Une page de connexion permet à l'utilisateur de se connecter avec un nom d'utilisateur et un mot de passe.
- Un employé peut modifier son mot de passe.

##### Exigences non-fonctionnelles

- Un employé sans connaissance en informatique doit pouvoir prendre en main l’application en moins de 20 minutes avec l'aide d'une formation ou d'un mode d'emploi.
- Le système sera disponible 24 heures sur 24, avec un taux d'indisponibilité n'exédant pas 5 minutes par jour.
- Le système doit pouvoir gérer 20 utilisateurs à la fois, avec un temps de réponse inférieur à 500 ms.
- Le système doit pouvoir démarrer après une panne en moins de 5 minutes.
- L'infrastructure complète sans l'application Docker doit faire moins de 5 Go.
- Les clients doivent pouvoir utiliser l'application via n'importe quel navigateur web moderne depuis un ordinateur.
- Il doit possible d'utiliser l'application depuis un navigateur de téléphone.
- Les mots de passe sont stockés dans la base de donnée sous forme de hash.
- La page web doit utiliser une version sûre du protocole https pour garantir la confidentialité et l'authenticité des données.
- Une protection contre le brute force est mise en place ainsi que contre les principales vulnérabilités connues (injection sql, timing attack, message d'erreur trop explicite, etc.).

### Description préliminaire de l’architecture

Notre architecture est composée de 4 conteneurs **Docker**, le tout orchestré par un **Docker compose**.

#### Backend

Le backend est une API REST écrite en **Node.js**, c'est avec celui-ci que communiqueront la base de données et le frontend.

#### Frontend

Le frontend est une application **React**, c'est l'interface que les utilisateurs finaux utiliseront avec un navigateur web.

#### Base de données

La base de données est une base de données **PostgreSQL** avec un script d'initialisation écrit en **SQL**.

#### Reverse proxy

Le reverse proxy utilise **Traefik** et permet au backend et au frontend d'être accessibles via le même port tout en répartissant les différentes requêtes au bon conteneur.

### Mockups / Landing page

### Description des choix techniques

#### Backend

Nous avons choisi **Node.js** pour son efficacité à gérer plusieurs clients simultanément sur un même thread, grâce à son architecture non bloquante et basée sur des événements. Cette approche permet de garder de bonnes performances, notamment pour dans le cadre d'API où un grand nombre de requêtes concurrentes sont effectuées.

Pour structurer notre application, nous utiliserons **Express.js**. Express.js simplifie la gestion des routes, des middlewares et des requêtes HTTP, permettant de créer des API RESTful de manière efficace et flexible. De plus il y a un grand nombre de plugins disponibles pour toutes sortes de fonctionnalités.

#### Frontend

Nous avons choisi **React** pour sa popularité lorsqu'il s'agit de développer des interfaces web modernes et pour que les utilisateurs puissent bénéficier d'une expérience fluide. Nous avons également choisi d'utiliser **MUI** afin de disposer de composants préfabriqués et d'une interface intuitive.

#### Base de données

Nous avons choisi **PostgreSQL** parce que c'est un SGBD open source reconnu pour sa fiabilité et qu'il est idéal pour les applications nécessitant un haut niveau de performance.

#### Reverse proxy

Nous avons choisi d'implémenter un reverse proxy afin de communiquer en http avec le serveur backend et le serveur frontend et de gérer la connexion ssl en un seul point. De plus, il permet de faire du load balancing avec sticky session et de rediriger certaines url sur un conteneur spécifique (/api).

### Description du processus de travail

Nous avons choisi **l'Extreme Programming** pour développer notre application parmi les méthodes Agiles. Nous avons choisi XP pour les raisons suivantes:

- Cycles de développement court
- Tests automatisés
- Planification progressive et flexible

Nous avons décidé de mettre en place les pratiques suivantes pour nous aider dans le développement:

- Programmer en paire
- Cycle hebdomadaire
- Build en 10 minutes
- Intégration continue
- Test-first programming
