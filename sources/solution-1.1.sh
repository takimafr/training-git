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
if [ $1 = "debug" ]; then read  -n 1; fi
git update-index --add fichier1.txt
git update-index --add dossier1/fichier2.txt
git update-index --add dossier1/dossier2/fichier3.txt
if [ $1 = "debug" ]; then read  -n 1; fi
echo 'Writing tree'
t=$(git write-tree)
if [ $1 = "debug" ]; then read  -n 1; fi
echo "Committing tree $t"
c=$(echo 'my first commit' | git commit-tree $t)
echo "Committed $c"
if [ $1 = "debug" ]; then read  -n 1; fi
echo 'update' >> dossier1/dossier2/fichier3.txt
git hash-object -w dossier1/dossier2/fichier3.txt
git update-index --add dossier1/dossier2/fichier3.txt
if [ $1 = "debug" ]; then read  -n 1; fi
echo 'Writing tree'
t2=$(git write-tree)
if [ $1 = "debug" ]; then read  -n 1; fi
echo "Committing tree $t2"
c2=$(echo 'my second commit' | git commit-tree $t2 -p $c)
if [ $1 = "debug" ]; then read  -n 1; fi
echo 'update' >> fichier1.txt
git hash-object -w fichier1.txt
git update-index --add fichier1.txt
if [ $1 = "debug" ]; then read  -n 1; fi
echo 'Writing tree'
t3=$(git write-tree)
if [ $1 = "debug" ]; then read  -n 1; fi
echo "Committing tree $t3"
c3=$(echo 'my third commit' | git commi t-tree $t3 -p $c2)
if [ $1 = "debug" ]; then read  -n 1; fi
git tag -a 1.0.0 $c3 -m "my first tag"
git log --stat $c3
if [ $1 = "debug" ]; then read  -n 1; fi