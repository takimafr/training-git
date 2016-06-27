#!/bin/bash
rm -rf workspace
unzip -d workspace git-repo-content.zip
cd workspace
echo "-----------------------------------------"
echo "Initializing git repository"
echo "-----------------------------------------"
git init
echo "-----------------------------------------"
echo " Exercise 1.1"
echo "-----------------------------------------"
git hash-object -w fichier1.txt
git hash-object -w dossier1/fichier2.txt
git hash-object -w dossier1/dossier2/fichier3.txt
git update-index --add fichier1.txt
git update-index --add dossier1/fichier2.txt
git update-index --add dossier1/dossier2/fichier3.txt
echo 'Writing tree'
t=$(git write-tree)
echo "Committing tree $t"
c=$(echo 'my first commit' | git commit-tree $t)
echo "Committed $c"
echo 'update' >> dossier1/dossier2/fichier3.txt
git hash-object -w dossier1/dossier2/fichier3.txt
git update-index --add dossier1/dossier2/fichier3.txt
echo 'Writing tree'
t2=$(git write-tree)
echo "Committing tree $t2"
c2=$(echo 'my second commit' | git commit-tree $t2 -p $c)
echo 'update' >> fichier1.txt
git hash-object -w fichier1.txt
git update-index --add fichier1.txt
echo 'Writing tree'
t3=$(git write-tree)
echo "Committing tree $t3"
c3=$(echo 'my third commit' | git commi t-tree $t3 -p $c2)
git tag -a 1.0.0 $c3 -m "my first tag"
echo "-----------------------------------------"
echo "Exercise 1.2"
echo "-----------------------------------------"
echo "Creating branch references"
git update-ref refs/heads/master $c3
git update-ref refs/heads/old $c2
git symbolic-ref HEAD refs/heads/old
git update-ref refs/tags/0.1.0 $c1
echo "Creating remote repository"
cd ..
mkdir remote-repository
cd remote-repository
git init --bare
echo "Adding remote repository in project"
cd ../workspace
git remote add origin remote-repository
echo "Pushing project to remote"
git push origin master
echo "Pushing tags"
git push --tag origin
git tree