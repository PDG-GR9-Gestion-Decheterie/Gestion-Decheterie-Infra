# Mode d'emploi pour lancer le projet en local

## Prérequis

Avant de commencer, assurez-vous d'avoir les éléments suivants installés sur votre machine :
- [Git](https://git-scm.com/)
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## Étapes pour lancer le projet

1. **Cloner les dépôts Git**

   Vous devez cloner les trois dépôts Git suivants dans le même dossier pour des raisons de chemin d'accès :

   ```bash
   git clone https://github.com/PDG-GR9-Gestion-Decheterie/Gestion-Decheterie-Infra.git
   git clone https://github.com/PDG-GR9-Gestion-Decheterie/Gestion-Decheterie-Backend.git
   git clone https://github.com/PDG-GR9-Gestion-Decheterie/Gestion-Decheterie-Frontend.git
   ```

   Assurez-vous que les trois dépôts sont dans le même dossier parent. Par exemple :

   ```bash
    /votre-dossier-projet
    ├── Gestion-Decheterie-Infra
    ├── Gestion-Decheterie-Backend
    └── Gestion-Decheterie-Frontend
   ```
2. **Lancer le projet en local**
Pour lancer le projet en local, suivez les étapes ci-dessous :
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

3. **Accéder à l'application**
Une fois le lancement terminé, vous pouvez accéder à l'application en ouvrant un navigateur et en allant à l'URL suivante :
```
https://localhost
```
Vous devriez maintenant voir l'application en cours d'exécution.

### Informations de connexion
| idlogin | password | fonction |
|:---------:|:----------:|:----------:|
|   jdoe      |     123     |   Responsable       |
|    jferrara     |   123       |    Secrétaire      |
|   asmith      |     123     |      Employé    |
|   rsmith2      |     123     |      Chauffeur    |

## Autres
### Explication du fonctionnement dans `Infra`

Le dossier `Gestion-Decheterie-Infra` contient plusieurs sous-dossiers importants pour la gestion de l'infrastructure :

- **dev** : Ce dossier contient une configuration qui permet de monter notre infrastructure dans Docker avec des données de test et des variables d'environnement spécifiques à l'environnement de développement. Les images Docker sont construites en local.

- **release** : Ce dossier est utilisé pour lancer la version de production sur notre serveur. La principale différence réside dans les variables d'environnement, les données insérées dans la base de données, et les certificats SSL pour le protocole HTTPS. Dans cette version, les images Docker sont récupérées depuis Docker Hub.

- **test** : Ce dossier contient des données de test utilisées pour les tests unitaires.
### Documentation
Nous avons mis en place une documentation interactive avec Swagger pour notre API. Pour y accéder, il suffit d'ajouter `/api-docs` à l'URL de votre application. Par exemple, si votre application est en cours d'exécution sur `http://localhost`, vous pouvez accéder à la documentation Swagger en allant à l'URL suivante :
http://localhost/api-docs
Cette documentation vous permet de visualiser et de tester les différentes routes de l'API de manière interactive.