# Pipeline CI/CD : Mode d'Emploi

## Amener une Modification en Production

Ce guide vous explique comment apporter une modification au code et l'amener en production en utilisant notre pipeline CI/CD.

### Étape 1 : Créer une Nouvelle Branche de Développement

Commencez par créer une nouvelle branche à partir de la branche `main` pour travailler sur votre fonctionnalité ou correction de bug :

```bash
git checkout main
git pull origin main
git checkout -b ma-nouvelle-fonctionnalite
```
### Étape 2 : Développer et Commiter vos Modifications
Faites vos modifications dans le code. Une fois terminé, ajoutez et commitez vos changements :

```bash
git add .
git commit -m "Ajout de ma nouvelle fonctionnalité"
```
### Étape 3 : Pousser les Modifications sur le Dépôt Distant

Poussez votre branche de développement vers le dépôt distant pour créer une merge request :

```bash
git push origin ma-nouvelle-fonctionnalite
```
### Étape 4 : Créer une Merge Request
- Accédez à votre dépôt sur GitHub.
- Créez une merge request pour fusionner votre branche ?  `ma-nouvelle-fonctionnalite` dans `main`.
- Demandez à un collègue de réviser votre *merge request*.
### Étape 5 : Revue et Fusion de la Merge Request
Une fois que votre *merge request* est approuvée, elle peut être fusionnée dans la branche `main`. Cette action déclenchera automatiquement le pipeline CI/CD.

### Étape 6 : Exécution Automatique du Pipeline
Le pipeline CI/CD exécutera les actions suivantes automatiquement :

1. **Tests Automatisés** : Les tests d'intégration seront exécutés pour vérifier que tout fonctionne correctement.
2. **Construction de l'Image Docker** : Une nouvelle image Docker sera construite avec les dernières modifications.
3. **Publication sur Docker Hub** : L'image Docker sera publiée sur Docker Hub.

### Étape 7 : Déploiement sur les Serveurs
Les serveurs de production peuvent maintenant récupérer la nouvelle image Docker et redémarrer les services :
    
```bash
docker compose pull
docker compose up -d
```
Votre modification est maintenant en production et disponible pour les utilisateurs.

