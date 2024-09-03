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
4. **Créer une Issue**

    Avant de commencer à travailler sur votre contribution, créez une issue pour discuter de votre idée. Cela permettra de s'assurer que votre contribution est nécessaire et qu'elle est en ligne avec les objectifs du projet.

    Pour créer une issue, allez sur la page du dépôt GitHub et cliquez sur le bouton "Issues". Cliquez ensuite sur le bouton "New Issue" et remplissez le formulaire.

    Une fois que vous avez créé l'issue, vous pouvez commencer à travailler sur votre contribution.
5. **Faire vos modifications**

    Apportez les modifications nécessaires à votre branche. Assurez-vous de suivre les conventions de codage et les bonnes pratiques du projet.

6. **Commiter vos modifications**

    Une fois vos modifications terminées, ajoutez-les à l'index et faites un commit :
    ```bash
    git add .
    git commit -m "Ajout de ma nouvelle fonctionnalité"
    ```

7. **Pousser votre branche**

    Poussez votre branche vers votre fork sur GitHub :
    ```bash	
    git push origin ma-nouvelle-fonctionnalite
    ```
8. **Créer une Pull Request**

    Allez sur la page GitHub de votre fork et cliquez sur le bouton "New Pull Request". Sélectionnez la branche que vous avez créée et soumettez la Pull Request (PR) vers le dépôt principal. Assurez-vous de décrire votre contribution et de mentionner l'issue que vous avez créée comme ceci : `"Fix #123"` ou `"Closes #123"`.

9. **Revue de code**

    Votre Pull Request sera examinée par les mainteneurs du projet. Ils peuvent vous demander des modifications ou des améliorations avant de fusionner votre contribution sur la branche principale.