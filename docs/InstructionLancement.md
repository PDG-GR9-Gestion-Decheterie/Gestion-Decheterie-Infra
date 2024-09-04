# Instructions de lancement

## Prérequis

Avant de commencer, assurez-vous d'avoir les éléments suivants installés sur votre machine :
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

Assurez-vous également d'avoir une clé Google API pour le service Google Map. Si vous n'avez pas de clé, vous pouvez en créer une en suivant ce [lien](https://developers.google.com/maps/documentation/javascript/get-api-key?hl=fr) ou la demander à un membre du groupe.

## Lancer l'application en local

### 1. Télécharger les releases des trois dépôts Git

   - [Gestion-Decheterie-Infra](https://github.com/PDG-GR9-Gestion-Decheterie/Gestion-Decheterie-Infra/releases)
   - [Gestion-Decheterie-Backend](https://github.com/PDG-GR9-Gestion-Decheterie/Gestion-Decheterie-Backend/releases)
   - [Gestion-Decheterie-Frontend](https://github.com/PDG-GR9-Gestion-Decheterie/Gestion-Decheterie-Frontend/releases)

### 2. Extraire les releases

   Extrayez les archives téléchargées dans un même dossier. Par exemple :

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

### 3. Lancer le projet

Mettez la clé Google API pour le service Google Map dans le fichier [`Gestion-Decheterie-Infra/dev/.env`](../dev/.env) :
```bash
REACT_APP_GOOGLE_MAPS_API_KEY=YOUR_API_KEY
```
Accédez au dossier `Gestion-Decheterie-Infra/dev` :
```bash
cd Gestion-Decheterie-Infra/dev
```

> **Note :** Ce dossier contient une configuration qui permet de monter notre infrastructure dans Docker avec des données de test et des variables d'environnement spécifiques à l'environnement de développement localhost. Les images Docker sont construites en local. Les certificats SSL sont auto-signés c'est pourquoi nous avons un warning de sécurité dans le navigateur.

Exécutez la commande suivante pour construire et démarrer les conteneurs Docker :
```bash
docker compose up --build
```
Cette commande va automatiquement :
- Créer les images Docker
- Lancer les conteneurs Docker
- Créer le schéma de la base de données
- Remplir la DB avec les données de test

### 4. Accéder à l'application
Une fois le lancement terminé, vous pouvez accéder à l'application en ouvrant un navigateur et en allant à l'URL suivante : [https://localhost](https://localhost).

Vous devriez maintenant voir l'application en cours d'exécution.

### Informations de connexion
|  idlogin  | password |   fonction    |
|:---------:|:--------:|:-------------:|
|   jdoe    |   123    | Responsable   |
| jferrara  |   123    | Secrétaire    |
|  asmith   |   123    |   Employé     |
| rsmith2   |   123    |   Chauffeur   |


### Documentation des endpoints de l'API
Nous avons mis en place une documentation interactive avec Swagger pour notre API. Pour y accéder, il suffit d'ajouter `/api-docs` à l'URL de votre application. Par exemple, si votre application est en cours d'exécution sur `https://localhost`, vous pouvez accéder à la documentation Swagger en allant à l'URL suivante :
https://localhost/api-docs
Cette documentation vous permet de visualiser et de tester les différentes routes de l'API de manière interactive.

## Lancer l'application en production

### 1. Télécharger la release de l'infrastructure et les fichiers nécessaires

```bash
curl -L -o release-asset.tar.gz https://github.com/PDG-GR9-Gestion-Decheterie/Gestion-Decheterie-Infra/archive/refs/tags/V1.0.tar.gz
```

```bash
curl -L -o source.csv https://github.com/PDG-GR9-Gestion-Decheterie/Gestion-Decheterie-Infra/releases/download/V1.0/source.csv
```

### 2. Extraire les fichiers

```bash
tar -xzf release-asset.tar.gz
```

```bash
rm -rf release-asset.tar.gz
```

```bash
mv source.csv Gestion-Decheterie-Infra-1.0/dataAdresse/
```

```bash
cd Gestion-Decheterie-Infra-1.0/release/
```

### 3. Configurer les paramètres de l'application

```bash
nano .env # Ajoutez votre clé Google API pour le service Google Map

.....

REACT_APP_GOOGLE_MAPS_API_KEY=YOUR_API_KEY
```
   
```bash
chmod 600 traefik/acme.json
```

### 4. Lancer l'application

```bash
sudo docker compose up --build -d
```

Vous devriez maintenant voir l'application en cours d'exécution sur votre serveur.

## Demonstration

Une démonstration de l'application en production est disponible à l'adresse suivante : 

[https://gestion-decheterie.internet-box.ch/](https://gestion-decheterie.internet-box.ch/)

Vous pouvez vous y connecter avec les identifiants suivants :
   - Identifiant : `admin`
   - Mot de passe : `jesuisicietpasla`
