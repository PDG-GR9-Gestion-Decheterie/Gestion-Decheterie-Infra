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

- Un employé possède un nom, prénom, une date de naissance, un numéro de téléphone, une adresse, date de début contrat, une fonction, un supérieur et un type de permis (B, C) (pas obligatoirement). Chaque employé est affecté à une déchèterie et possède un login pour se connecter à l’application.
- Une adresse est décrite par une rue et numéro, un code postal, une ville et un pays
- Il y a comme fonction : Responsable, Secrétaire, Chauffeur, Employé.

Une déchèterie principale en plus d’avoir les mêmes attributs qu’une déchèterie possède des moyens de transport des déchets (véhicules).

Les contenants sont soit des bennes, des palettes, des grandes caisses ou des big bag et possède un type de déchets contenu.

- Les bennes, les grandes caisses, les big bag et les palettes on une couleur et une capactié maximale (en litre).
- Les big bag ont une taille : petite, moyenne ou grande.
- Les palettes possèdent un nombre de cadres (entre 0 et 4).

Les moyens de transport sont soit des camions, soit des camionnettes et possèdent un numéro d’immatriculation, année de fabrication, date de la dernière expertise, une consommation de carburant ainsi qu'une indication avec ou sans remorque. Les camions et la camionette peuvent transporter tous types de contenants.

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
- Seul un secrétaire ou responsable peut ajouter/modifier/supprimer/accéder à la table véhicule et la table contenant.

##### Besoins fonctionnels - Connexion

- Une page de connexion permet à l'utilisateur de se connecter avec un nom d'utilisateur et un mot de passe.
- Un employé peut modifier son mot de passe.

##### Exigences non-fonctionnelles

- Un employé sans connaissance en informatique doit pouvoir prendre en main l’application en moins de 20 minutes avec l'aide d'une formation ou d'un mode d'emploi.
- Le système sera disponible 24 heures sur 24, avec un taux d'indisponibilité n'exédant pas 5 minutes par jour.
- Le système doit pouvoir gérer 1000 requêtes par seconde avec 90% du temps de réponse inférieure à 500ms.
- Le système doit pouvoir démarrer après une panne en moins de 5 minutes.
- L'infrastructure complète sans l'application Docker doit faire moins de 5 Go.
- Les clients doivent pouvoir utiliser l'application via n'importe quel navigateur web moderne depuis un ordinateur.
- Il doit être possible d'utiliser l'application depuis un navigateur de téléphone.
- Les mots de passe sont stockés dans la base de donnée sous forme de hash.
- La page web doit utiliser une version sûre du protocole https pour garantir la confidentialité et l'authenticité des données.
- Une protection contre le brute force est mise en place ainsi que contre les principales vulnérabilités connues (injection sql, timing attack, message d'erreur trop explicite, etc.).

### Description préliminaire de l’architecture

Notre architecture est composée de 4 conteneurs **Docker**, le tout orchestré par un **Docker compose**.
Nous utiliserons un PC fixe comme serveur que nous ferons tourner à la maison. Ce serveur nous permettra de déployer notre application et faire tourner notre infrastructure.
Le serveur utilisera comme OS **ubuntu server** avec docker installé.

#### Backend

Le backend est une API REST écrite en **Node.js**, c'est avec celui-ci que communiqueront la base de données et le frontend.

#### Frontend

Le frontend est une application **React**, c'est l'interface que les utilisateurs finaux utiliseront avec un navigateur web.

#### Base de données

La base de données est une base de données **PostgreSQL** avec un script d'initialisation écrit en **SQL**.

#### Reverse proxy

Le reverse proxy utilise **Traefik** et permet au backend et au frontend d'être accessibles via le même port tout en répartissant les différentes requêtes au bon conteneur.

### Mockups / Landing page
**Écran de connexion :** L'utilisateur démarre en saisissant son nom d'utilisateur et son mot de passe sur une page de connexion sécurisée pour accéder au système.

**Accueil après connexion :** Une fois connecté, l'utilisateur arrive sur la page d'accueil du logiciel. Cette page présente différentes options de navigation, telles que "Employés", "Ramassage", "Véhicules", et "Déchetteries", chacune représentée par un bouton distinct. A savoir que ceci n'est qu'un exemple. Les boutons pourront varier selon la personne connecté.

**Itinéraire :**  Cette page est dédiée aux chauffeurs et leur permet de visualiser l'itinéraire de la journée pour leurs ramassages. La carte affiche les trajets planifiés, facilitant la gestion des itinéraires et la navigation pour les chauffeurs.

**Sélection de "Ramassage" :** L'utilisateur sélectionne l'option "Ramassage" pour accéder à la gestion des ramassages. Cela les redirige vers une page où ils peuvent voir la liste de ramassages concernant ses déchèteries.

**Détail d'un Ramassage :** En cliquant sur un ramassage spécifique dans la liste, l'utilisateur est dirigé vers une page de détails. Cette page affiche des informations complètes sur le ramassage sélectionné, y compris l'itinéraire sur une carte, l'état actuel du ramassage, et d'autres informations critiques.

**Modification/Suppression :** L'utilisateur a également la possibilité de modifier les détails du ramassage ou de le supprimer.
Ajout de Ramassage: L'utilisateur peut remplir un formulaire pour ajouter un nouveau ramassage, en renseignant toutes les informations nécessaires telles que l'ID, la date, le véhicule utilisé, etc., avant de sauvegarder ces informations.

**Autres Modules :** Bien que ce mockup se concentre sur la fonctionnalité "Ramassage", les autres modules comme "Employés", "Véhicules", ,"Déchetteries", etc... suivent une logique similaire. L'utilisateur peut accéder à ces sections depuis le menu, visualiser des listes d'éléments (employés, véhicules, etc.), consulter des détails spécifiques, ajouter de nouveaux éléments, et modifier ou supprimer les existants.

![Mockup](img/Mockup_schema.png "schéma mockup")

Nous avons également créer une [Landing page](https://pdg-gr9-gestion-decheterie.github.io/) que vous pouvez aller consulter à l'url suivante : https://pdg-gr9-gestion-decheterie.github.io

### Description des choix techniques

#### Backend

Nous avons choisi **Node.js** pour son efficacité à gérer plusieurs clients simultanément sur un même thread, grâce à son architecture non bloquante et basée sur des événements. Cette approche permet de garder de bonnes performances, notamment pour dans le cadre d'API où un grand nombre de requêtes concurrentes sont effectuées.

Pour structurer notre application, nous utiliserons **Express.js**. Express.js simplifie la gestion des routes, des middlewares et des requêtes HTTP, permettant de créer des API RESTful de manière efficace et flexible. De plus il y a un grand nombre de plugins disponibles pour toutes sortes de fonctionnalités.

Nous utiliserons **Passport** pour gérer les cookies pour l'authentification des utilisateurs. Lié à bCrypt, cela permet d'avoir une authentificaiton sûre avec un stockage des mots de passe sécurisé dans la base de données.

#### Frontend

Nous avons choisi **React** pour sa popularité lorsqu'il s'agit de développer des interfaces web modernes et pour que les utilisateurs puissent bénéficier d'une expérience fluide. Nous avons également choisi d'utiliser **MUI** afin de disposer de composants préfabriqués et d'une interface intuitive.

#### Base de données

Nous avons choisi **PostgreSQL** parce que c'est un SGBD open source reconnu pour sa fiabilité et qu'il est idéal pour les applications nécessitant un haut niveau de performance.

#### Reverse proxy

Nous avons choisi d'implémenter un reverse proxy afin de communiquer en http avec le serveur backend et le serveur frontend et de gérer la connexion ssl en un seul point. De plus, il permet de faire du load balancing avec sticky session et de rediriger certaines url sur un conteneur spécifique (/api).
Il permet également de gérer plusieurs nom de domaine différents sur la même adresse IP publique.

### Description du processus de travail

Nous avons opté pour la méthode Extreme Programming (XP) afin de développer notre application, après avoir comparé diverses méthodes Agiles. Cette décision s'appuie sur les avantages spécifiques de XP, qui incluent :

Des cycles de développement courts : Ils nous permettent de réagir rapidement aux besoins changeants et d'améliorer continuellement l'application.
Des tests automatisés : Ces tests garantissent la fiabilité du code, réduisent les erreurs et accélèrent les cycles de développement.
Une planification progressive et flexible : Cette approche nous donne la possibilité d'adapter facilement nos priorités selon l'évolution du projet.

Nous avons décidé de mettre en place les pratiques suivantes pour nous aider dans le développement:

#### Travail en pair programming

Nous avons formé deux groupes de deux personnes, chacun travaillant en programmation en paire. Cela nous permet de répartir efficacement les tâches tout en ayant une responsabilité partagée entre 2 personnes.
Chaque groupe se concentre sur un aspect spécifiques du projet.

Régulièrement, nous organisons de "petites réunions" pour synchroniser nos avancées et discuter des potentiels problèmes rencontrés et/ou des questions à adresser aux assistants.
Cela favorise une communication ouverte et permet un retour d'information continu.

#### Tests avant le code (Test-First Programming)

Nous appliquons le principe du **Test-First Programming**, qui consiste à écrire des tests avant de commencer l'implémentation des fonctionnalités afin de garantir que chaque fonctionnalité est validée et fonctionne comme pérvu avant d'être intégrée dans le projet.

#### Répartition des tâches

Après avoir imaginé notre projet et de toutes les fonctionnalités que nous souhaitons implémenter, une équipe s'est attardée sur la réalisation des mockups/landing page lorsque l'autre s'est occupé de la création de l'organisation Git ainsi que la mise en place de notre pipeline de développement.
Nous avons ensuite décidé de rester sur une double équipe de deux pour la suite pour la réalisation du backend d'une part et du frontend de l'autre.
Chaque équipe est responsable de son domaine tout en maintenant une cohérence entre les deux côtés de l'application.
Cependant, il n'est pas impossible qu'une personne bascule et s'occupe du domaine de l'autre groupe et inversement.

#### Structuration de notre travail

Comme mentionné au point précèdent, nous avons créer une organisation pour ce projet et nous y avons ajouté plusieurs repos répartis de manière claire :

- Infra
- Backend
- Frontend
- github.io (Landing page)

Cette organisation permet une séparation et une gestion plus facile sur les différents aspects du projet.

##### Intégration continue et gestion des branches

Tous nos ajouts et modification de code sont effectués sur des branches de développement (**dev**). Une fois que le travail sur une fonctionnalité (ou tâche) est terminé, nous effectuons un "merge request" pour intégrer ces nouveauté dans la branche **main**.
Une autre personne doit ensuite consulter ce merge request et l'approuver afin que ces modification s'applique et que le pipeline s'occupe d'appliquer ces modifications automatiquement.

