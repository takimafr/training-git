#!/bin/bash
bash solution-2.sh $1
rm -rf workspace-2
git clone remote-repository.git workspace-2
cd workspace-2
echo "-----------------------------------------"
echo " Exercise 4"
echo "-----------------------------------------"
echo "-----------------------------------------"
echo "Developer 2"
echo "-----------------------------------------"
echo "-----------------------------------------"
echo "Changing files"
echo "-----------------------------------------"
echo 'update1' >> fichier1.txt
touch dossier1/fichier4.txt && echo 'update' >> dossier1/fichier4.txt
rm dossier1/fichier2.txt
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Staging changes"
echo "-----------------------------------------"
git add .
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Commit & push changes on branch master"
echo "-----------------------------------------"
git commit -m "my fourth commit as developer 2 on branch master"
git push origin master
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "-----------------------------------------"
echo "-----------------------------------------"
echo "Developer 1"
echo "-----------------------------------------"
cd ../workspace
echo "-----------------------------------------"
echo "Changing files"
echo "-----------------------------------------"
echo 'update2' >> fichier1.txt
echo 'update' >> dossier1/fichier2.txt
echo 'update' >> dossier1/dossier2/fichier3.txt
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Staging changes"
echo "-----------------------------------------"
git add . 
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Commit changes on master"
echo "-----------------------------------------"
git commit -m "my fourth commit as developer 1 on branch master"
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Result tree looks like:"
echo "-----------------------------------------"
git tree
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "-----------------------------------------"
echo "-----------------------------------------"
echo "-----------------------------------------"
echo "Attempting to push"
echo "-----------------------------------------"
git push origin master
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Yes... Developer 2 has already pushed a fourth commit... And you didn't know about it."
echo "-----------------------------------------"
echo "-----------------------------------------"
echo "Fetching changes"
echo "-----------------------------------------"
git fetch
echo "-----------------------------------------"
echo "Tree looks like"
echo "-----------------------------------------"
git tree
echo "-----------------------------------------"
echo "Attempting rebase"
echo "-----------------------------------------"
git rebase origin/master
echo "-----------------------------------------"
echo "Yes... Developer 2 has made concurrent changes with you. You know what to do!"
echo "-----------------------------------------"
echo "-----------------------------------------"
echo "Merging paths"
echo "-----------------------------------------"
echo 'update3' > fichier1.txt
rm dossier1/fichier2.txt
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Staging changes"
echo "-----------------------------------------"
git add .
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Continuing rebase"
echo "-----------------------------------------"
if [ $1 = "debug" ]; then read  -n 1; fi
git rebase --continue
echo "-----------------------------------------"
echo "Push new commit"
echo "-----------------------------------------"
git push origin master
echo "-----------------------------------------"
echo "Final tree"
echo "-----------------------------------------"
git tree
