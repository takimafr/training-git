git init
git hash-object -w fichier1.txt
git hash-object -w dossier1/fichier2.txt
git hash-object -w dossier1/dossier2/fichier3.txt
git update-index --add fichier1.txt
git update-index --add dossier1/fichier2.txt
git update-index --add dossier1/dossier2/fichier3.txt
echo 'Writing tree'
t=$(git write-tree)
echo "Committing tree $t"
c=$(echo 'mon premier commit' | git commit-tree $t)
echo "Committed $c"
echo 'update' >> dossier1/dossier2/fichier3.txt
git hash-object -w dossier1/dossier2/fichier3.txt
git update-index --add dossier1/dossier2/fichier3.txt
echo 'Writing tree'
t2=$(git write-tree)
echo "Committing tree $t2"
c2=$(echo 'mon deuxieme commit' | git commit-tree $t2 -p $c)
echo 'update' >> fichier1.txt
git hash-object -w fichier1.txt
git update-index --add fichier1.txt
echo 'Writing tree'
t3=$(git write-tree)
echo "Committing tree $t3"
c3=$(echo 'mon troisieme commit' | git commit-tree $t3 -p $c2)
git tag -a $c3 -m "premier tag annoted"
git log --stat $c3
