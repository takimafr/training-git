#Git Cheatsheet  

##1. Installation d'un environnement
###1.1. GitConfig
>`$ git config –-global user.name "votre nom"`  

>`$ git config –global user.email "votre@email.com"`  

Editer le fichier .gitconfig via la commande:  

>`$ git config --global -e`  

Pour activer la colorisation syntaxique et les alias "lol" et "lola", ajouter les lignes suivantes au .gitconfig:  
>  [alias]  
  tree = log --graph --decorate --pretty=oneline --abbrev-commit --all  
  branch-merged = "!f(){ for branch in `git branch -r --merged | grep -v HEAD | grep -v origin/master | grep -v origin/release` ;do git show --format=\"%C(yellow)%d %Cgreen%aN %C(cyan)%ar\" $branch | head -n 1 ; done }; f"
  branch-not-merged = "!f(){ for branch in `git branch -r --no-merged | grep -v HEAD | grep -v origin/master | grep -v origin/release` ;do git show --format=\"%C(yellow)%d %Cgreen%aN %C(cyan)%ar\" $branch | head -n 1 ; done }; f"

  [color]  
  branch = auto  
  diff = auto  
  interactive = auto  
  status = auto  

###1.2. Gestion des fin de ligne
**Windows** : les fins de lignes sont modélisées par un CRLF (Carriage Return Line Feed <=> \r\n)  
**Linux** : modélisées par LF (Line Feed <=> \n)  
**Git** : tout est stocké en LF par convention  

**Client Windows** : doit toujours faire une conversion **CRLF → LF** quand il écrit dans la base de données, et doit toujours faire la conversion **LF →CRLF** quand il récupère des données de la base.  
>`$ git config –-global core.autocrlf true`

**Client Linux** : doit toujours faire une conversion CRLF → LF quand il écrit dans la base de données (mais n'en a normalement pas besoin) et n'aura aucune conversion à faire quand il récupère les données de la la base.  
>`$ git config –-global core.autocrlf input`

##2. Initialisation ou Clonage d'un repository
###2.1. Initialisation d'un nouveau repo central (=origin)
Pour un nouveau projet, vous allez avoir l'occasion d'initialiser un repository central sur votre serveur. C'est ici que les clients devront se connecter et pousser leurs modifications. Pour initialiser un projet monprojet :
>`$ mkdir monrepo.git`  
>`$ cd monrepo.git`  
>`$ git –-bare init`  

###2.2. Initialisation d'un nouveau repo local
Se mettre à la racine du dossier qui contient ou contiendra votre projet, et exécuter la commande
>`$ git init`

Si le fichier a un repo central distant (=remote) sur lequel il doit être répliqué il faut le déclarer. Par convention, on utilise le nom « origin » pour le dépôt principal

Le dépôt peut être une URI :  
>`$ git add remote origin https://github.com/moi/monrepo.git`  

ou autre chose (un repo distant via ssh par exemple) :  

>`$ git add remote origin git@monserveur:~/git/monrepo.git`  

###2.3. Clonage d'un repo existant
Si le projet existe déjà, il suffit de le cloner depuis son repo distant
>`$ git clone git@monserveur:~/git/monrepo.git`  

Un dossier monrepo sera créé dans le répertoire où vous êtes

##3. Commandes principales

###3.5. Commandes Incontournables
####Afficher l'état de la Staging area
>`git status`

####Afficher l'arbre principal avec toutes les branches (attention: c'est un alias créé avec votre gitconfig)
>`git tree`

####Remiser (=stash) vos changements non commités pour changer de branche temporairement
>`git stash`

####Reprendre (=pop) vos changements non commités une fois de retour sur la branche
>`git stash pop`

###3.2. Branches
(+) Créer une branche au point actuel sans se placer dessus:  
>`$ git branch branch_name`  

(+) Se placer sur une branche et la créer au point actuel si elle n'existe pas:  
>`$ git checkout -b branch_name`  

(x) Supprimer une branche du repo local  
>`$ git branch -D branch_name`

(x) Supprimer une branche du repo origin (deux solutions)  
>`$ git push origin --delete branch_name` (git v1.7.0 et >)  
ou  
>`$ git push origin :branch_name` (anciennes versions)

(>) Pousser une branche sur le repo origin:
>`$ git push origin branchelocale:branchedistante .`  
ou si les deux branches ont le meme nom:  
>`$ git push origin branche .`  

(T) Créer un tag annoté sur un commit:
>`$ git tag -a nom_du_tag sha_du_commit -m "message du tag pour la version vX.X"`  

(T) Créer un tag lightweight sur un commit:
>`$ git tag nomdutag sha_du_commit`  

(<) Récupérer la dernière version des branches depuis le repo origin:
>`$ git fetch origin`  



###3.3. Index
(+) Ajouter des nouveaux fichiers ou des fichiers modifiés à l'index (2 exemples)  
>`$ git add .`  
>>ajoute tous les fichiers du dossier courant et de ses sous dossiers  

>`$ git add file2.txt folder1/* folder2/*.txt`  
>>ajoute le fichier file2.txt, tous les fichiers du dossier folder1, et tous les fichiers texte du dossier folder2  


(x) Enlever des fichiers de l'index (les replacera en tant que fichiers unstaged ou untracked):
>`$ git reset HEAD`  
>>enlève tous les fichiers non commités de l'index  

>`$ git reset HEAD file1.txt dossier1/*`  
>>enlève file1.txt et les fichiers du dossier1 de l'index  

###3.4. Commit
(+) Commiter les changements ajoutés à l'index:
>`$ git commit -m "message de votre commit" .`  


(+) Ajouter d'autres fichiers dans l'index au dernier commit (en cas d'oubli), si vous ne l'avez pas encore pushé sur le repo distant:  
>`$ git commit --amend -m "nouveau message qui remplacera l'ancien commit"`  

(x) Annuler proprement un commit (va créer un nouveau commit qui contient les changements inverses au précédent):  
>`$ git revert HEAD~nombreDeCommitsAAnnuler`  
>>ex: Annuler le commit précédent:  
>`$ git revert HEAD~1`  

###3.5. Rebase et rebase interactif
(^) Appliquer les commits de la branche distante qui diffèrent de la branche locale:  
>`$ git rebase origin/nomdelabranche`  

(e) Lancer un rebase interactif en remontant 4 commits:  
>`$ git rebase -i HEAD~3`  

Un contenu similaire à celui-ci apparait:  
>pick 4995a59 mon deuxieme commit  
>pick 531b54f mon troisieme commit  
>pick 0e9c8cc mon quatrieme commit  

Modifier le contenu en conséquence pour effectuer les actions suivantes:

####(e) Inverser l'ordre des commits 531b54f et 0e9c8cc:  
>pick 4995a59 mon deuxieme commit  
>pick 0e9c8cc mon quatrieme commit  
>pick 531b54f mon troisieme commit  

####(e) Fusionner le commit 531b54f avec son précédent 4995a59:  
>pick 4995a59 mon deuxieme commit  
>squash 531b54f mon troisieme commit  
>pick 0e9c8cc mon quatrieme commit  

####(x) Supprimer le commit 531b54f:  
>pick 4995a59 mon deuxieme commit  
>\#supprimer cette ligne: pick 531b54f mon troisieme commit   
>pick 0e9c8cc mon quatrieme commit  

####(e) Editer le commit 531b54f:  
>pick 4995a59 mon deuxieme commit  
>**edit** 531b54f mon troisieme commit  
>pick 0e9c8cc mon quatrieme commit  

Puis effectuer vos modifications, commiter, et exécuter  
>`$ git rebase --continue`  

##Bibliographie  
Une formation git très complète et facile d'accès (en anglais)  
>[http://git-scm.com/book/en](http://git-scm.com/book/en)  

Un livre très complet sur git (en anglais)  
>[https://github.com/blog/1640-git-internals-pdf-open-sourced](https://github.com/blog/1640-git-internals-pdf-open-sourced)  

Une cheatsheet des commandes git, répertoriées en couches (en anglais)  
>[http://ndpsoftware.com/git-cheatsheet.html](http://ndpsoftware.com/git-cheatsheet.html)

Un très bon document pour comprendre et choisir le workflow adapté à votre projet (en anglais)  
>[https://www.atlassian.com/git/workflows#!workflow-release-cycle](https://www.atlassian.com/git/workflows#!workflow-release-cycle)  

Un article qui donne une approche détaillée du workflow gitflow  
>[http://www.synbioz.com/blog/git-adopter-un-modele-de-versionnement-efficace](http://www.synbioz.com/blog/git-adopter-un-modele-de-versionnement-efficace)  
