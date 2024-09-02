# Instructions de contribution au projet

## Workflow de contribution

Nous utilisons un workflow Git standard pour gérer les contributions à notre projet. Voici les étapes à suivre pour contribuer :
1. **Forker le dépôt**

   Si vous souhaitez contribuer, commencez par forker le dépôt GitHub du projet. Vous pouvez le faire en cliquant sur le bouton "Fork" en haut à droite de la page du dépôt.

2. **Cloner votre fork**

   Clonez votre fork localement sur votre machine :

   ```bash
   git clone https://github.com/votre-utilisateur/Gestion-Decheterie-Backend.git
    ```
3. **Créer une branche pour votre contribution** 

    Créez une nouvelle branche pour votre contribution. Utilisez un nom de branche descriptif :
    ```bash	
    git checkout -b ma-nouvelle-fonctionnalite
    ```
4. **Faire vos modifications**
    Apportez les modifications nécessaires à votre branche. Assurez-vous de suivre les conventions de codage et les bonnes pratiques du projet.

5. **Commiter vos modifications**

    Une fois vos modifications terminées, ajoutez-les à l'index et faites un commit :
    ```bash
    git add .
    git commit -m "Ajout de ma nouvelle fonctionnalité"
    ```

6. **Pousser votre branche**

    Poussez votre branche vers votre fork sur GitHub :
    ```bash	
    git push origin ma-nouvelle-fonctionnalite
    ```
7. **Créer une Pull Request**

    Allez sur la page GitHub de votre fork et cliquez sur le bouton "New Pull Request". Sélectionnez la branche que vous avez créée et soumettez la Pull Request (PR) vers le dépôt principal.

8. **Revue de code**

    Votre Pull Request sera examinée par les mainteneurs du projet. Ils peuvent vous demander des modifications ou des améliorations avant de fusionner votre contribution.