# Mode d'emploi pour lancer le projet en local

## Prérequis

Avant de commencer, assurez-vous d'avoir les éléments suivants installés sur votre machine :
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## Étapes pour lancer le projet

Vous devez récupérer les releases des trois dépôts Git suivants et les extraire dans le même dossier pour des raisons de chemin d'accès :

1. **Télécharger les releases**

   Téléchargez les releases des trois dépôts Git suivants :

   - [Gestion-Decheterie-Infra](https://github.com/PDG-GR9-Gestion-Decheterie/Gestion-Decheterie-Infra/releases)
   - [Gestion-Decheterie-Backend](https://github.com/PDG-GR9-Gestion-Decheterie/Gestion-Decheterie-Backend/releases)
   - [Gestion-Decheterie-Frontend](https://github.com/PDG-GR9-Gestion-Decheterie/Gestion-Decheterie-Frontend/releases)

2. **Extraire les releases**

   Extrayez les archives téléchargées dans le même dossier parent. Par exemple :

   ```bash
    /votre-dossier-projet
    ├── Gestion-Decheterie-Infra
    ├── Gestion-Decheterie-Backend
    └── Gestion-Decheterie-Frontend
   ```

   Pour la release de l'infrastructure, vous devez extraire le contenu du dossier et prendre le fichier `source.csv` pour le mettre à la place de celui dans le dossier `dataAdresse`.

   ```bash
    /votre-dossier-projet
    ├── Gestion-Decheterie-Infra
    │   ├── dev
    │   ├── release
    │   └── dataAdresse
    │       └── source.csv
    ├── Gestion-Decheterie-Backend
    └── Gestion-Decheterie-Frontend
   ```

3. **Lancer le projet en local**
Pour lancer le projet en local, suivez les étapes ci-dessous :
- Mettre la clé Google API pour le service Google Map dans le fichier [`Gestion-Decheterie-Infra/dev/.env`](../dev/.env). Si vous n'avez pas de clé, vous pouvez en créer en suivant ce [lien](https://developers.google.com/maps/documentation/javascript/get-api-key?hl=fr) :
```bash
REACT_APP_GOOGLE_MAPS_API_KEY=YOUR_API_KEY
```
- Accédez au dossier `Gestion-Decheterie-Infra/dev` :
```bash
cd Gestion-Decheterie-Infra/dev
```
- Exécutez la commande suivante pour construire et démarrer les conteneurs Docker :
```bash
docker compose up --build
```
Cette commande va automatiquement :
- Créer les images Docker
- Lancer les conteneurs Docker
- Créer le schéma de la base de données
- Remplir la DB avec les données de test

4. **Accéder à l'application**
Une fois le lancement terminé, vous pouvez accéder à l'application en ouvrant un navigateur et en allant à l'URL suivante : [https://localhost](https://localhost).

Vous devriez maintenant voir l'application en cours d'exécution.

### Informations de connexion
|  idlogin  | password |   fonction    |
|:---------:|:--------:|:-------------:|
|   jdoe    |   123    | Responsable   |
| jferrara  |   123    | Secrétaire    |
|  asmith   |   123    |   Employé     |
| rsmith2   |   123    |   Chauffeur   |


### Documentation
Nous avons mis en place une documentation interactive avec Swagger pour notre API. Pour y accéder, il suffit d'ajouter `/api-docs` à l'URL de votre application. Par exemple, si votre application est en cours d'exécution sur `https://localhost`, vous pouvez accéder à la documentation Swagger en allant à l'URL suivante :
https://localhost/api-docs
Cette documentation vous permet de visualiser et de tester les différentes routes de l'API de manière interactive.

## Autres
### Explication du fonctionnement dans `Infra`

Le dossier `Gestion-Decheterie-Infra` contient plusieurs sous-dossiers importants pour la gestion de l'infrastructure :

- **dev** : Ce dossier contient une configuration qui permet de monter notre infrastructure dans Docker avec des données de test et des variables d'environnement spécifiques à l'environnement de développement localhost. Les images Docker sont construites en local. Les certificats SSL sont auto-signés c'est pourquoi nous avons un warning de sécurité dans le navigateur.

- **release** : Ce dossier est utilisé pour lancer la version de production sur notre serveur. La principale différence réside dans les variables d'environnement, les données insérées dans la base de données, et les certificats SSL (qui sont obtenu par le reverse proxy) pour le protocole HTTPS. Dans cette version, les images Docker sont récupérées depuis Docker Hub. Pour la lancer sur vos serveurs de production il faut modifier les variables d'environnement dans les fichier:
- `release/.env`
- `release/docker-compose.yaml`
- `release/traefik/traefik.yaml`  
Et exécuter la commande suivante sur le serveur  dans le dossier `Gestion-Decheterie-Infra/release` :
   ```bash
   docker compose up --build
   ```
   Identifiant et mot de passe pour accéder à l'application :
   - Identifiant : `admin`
   - Mot de passe : `jesuisicietpasla`

- **test** : Ce dossier contient des données de test utilisées pour les tests unitaires du backend lancés dans github actions.

