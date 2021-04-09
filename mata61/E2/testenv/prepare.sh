#!/bin/bash
# Has 1 argument (folder name)
# Run outside team repo

reponame=$1
testenv=$(pwd)
repotestenv="$testenv/$reponame"
feedback=/feedback/
inputs=/feedback/inputs/
oracle=/feedback/oracle/

# create branch feedback and checkout
echo `git branch feedback`
echo `git checkout feedback`

# create dirs and copy files
echo "criando diretórios"
mkdir "$repotestenv$feedback"


echo "copiando tests/ para feedback/"
cp -r "$testenv/tests/" "$repotestenv$feedback/"

cp -r ../scripts/* .

echo "buscando compile.sh"
echo `find . -name "compile.sh"`
echo
echo "done prepare."



