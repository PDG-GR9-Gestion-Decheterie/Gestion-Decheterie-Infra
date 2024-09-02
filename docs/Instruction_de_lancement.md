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
   git clone https://github.com/votre-utilisateur/Gestion-Decheterie-Infra.git
   git clone https://github.com/votre-utilisateur/Gestion-Decheterie-Backend.git
   git clone https://github.com/votre-utilisateur/Gestion-Decheterie-Frontend.git
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
- Créer la base de données
- Remplir les données de test
3. **Accéder à l'application**
Une fois le lancement terminé, vous pouvez accéder à l'application en ouvrant un navigateur et en allant à l'URL suivante :
```
https://localhost
```
Vous devriez maintenant voir l'application en cours d'exécution.
