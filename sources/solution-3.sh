#!/bin/bash
bash solution-2.sh $1
cd workspace
echo "-----------------------------------------"
echo " Exercise 3"
echo "-----------------------------------------"
echo "-----------------------------------------"
echo "Creating branch develop"
echo "-----------------------------------------"
git checkout -b develop
if [ $1 = "debug" ]; then read  -n 1; fi
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
echo "Commit & push changes on branch develop"
echo "-----------------------------------------"
git commit -m "my fourth commit on branch develop"
git push origin develop
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Coming back on master"
echo "-----------------------------------------"
git checkout master
if [ $1 = "debug" ]; then read  -n 1; fi
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
git commit -m "my fourth commit on branch master"
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
echo "Attempting to merge"
echo "-----------------------------------------"
git merge develop
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Yes... You have concurrently modified fichier1.txt and dossier1/fichier2.txt"
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
echo "Commit changes"
echo "-----------------------------------------"
git commit -m "Merge branch 'develop'"
if [ $1 = "debug" ]; then read  -n 1; fi
git tree