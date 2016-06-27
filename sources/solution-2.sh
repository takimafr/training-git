#!/bin/bash
rm -rf workspace
rm -rf remote-repository
unzip -d workspace git-repo-content.zip
cd workspace
echo "-----------------------------------------"
echo "Initializing git repository"
echo "-----------------------------------------"
git init
echo "-----------------------------------------"
echo " Exercise 2"
echo "-----------------------------------------"
git add .
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Commit staging"
echo "-----------------------------------------"
git commit -m 'my first commit'
git tag 0.1.0
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo 'Changing file & adding to staging'
echo "-----------------------------------------"
echo 'update' >> dossier1/dossier2/fichier3.txt
git add .
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Commit staging"
echo "-----------------------------------------"
git commit -m 'my second commit'
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo 'Changing file & adding to staging'
echo "-----------------------------------------"
echo 'update' >> fichier1.txt
git add .
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Commit staging"
echo "-----------------------------------------"
git commit -m 'my third commit'
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Tagging"
echo "-----------------------------------------"
git tag -a 1.0.0 -m "my first tag"
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Result tree"
echo "-----------------------------------------"
git tree
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "-----------------------------------------"
echo "-----------------------------------------"
echo "-----------------------------------------"
echo "Creating remote repository"
echo "-----------------------------------------"
cd ..
mkdir remote-repository
cd remote-repository
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Initializing remote repository"
echo "-----------------------------------------"
git init --bare
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Adding remote repository to project's remotes"
echo "-----------------------------------------"
cd ../workspace
git remote add origin ../remote-repository
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Push branch master & tags to remote"
echo "-----------------------------------------"
git push origin master
git push --tag origin
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "Result tree"
echo "-----------------------------------------"
git tree
if [ $1 = "debug" ]; then read  -n 1; fi
echo "-----------------------------------------"
echo "-----------------------------------------"
echo "-----------------------------------------"