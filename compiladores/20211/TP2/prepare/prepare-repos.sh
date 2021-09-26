#!/bin/bash
# Has 1 argument - the name of a folder that contains students repos
# Run outside such parent folder of studens repos 
# to prepare each student repo

foldername=$1
testenv=$(pwd)
grouptestenv="$testenv/$foldername" 
feedback=/feedback/
inputs=/feedback/inputs/
oracle=/feedback/oracle/
oracleok=/feedback/oracleok/
oraclenok=/feedback/oraclenok/

cd "$grouptestenv"
repos=$(ls)

for r in $repos; do
    echo "Repo name: $r"
    repotestenv="$grouptestenv/$r"
    echo "Dir: $repotestenv"
    cd  "$repotestenv"

# create branch feedback and checkout
    echo `git branch feedback`
    echo `git checkout feedback` 
    mkdir "$repotestenv$feedback"

    echo "copiando /tests para /feedback"
    cp -r "$testenv/tests/inputs" "$repotestenv$feedback/"
    cp -r "$testenv/tests/oracle" "$repotestenv$feedback/"
    cp -r "$testenv/tests/oracleok" "$repotestenv$feedback/"
    cp -r "$testenv/tests/oraclenok" "$repotestenv$feedback/"
    cp "$testenv/tests/README.md" "$repotestenv$feedback/"

    echo "copiando /scripts"
    cp -r "$testenv/scripts/*" .

    echo "buscando compile.sh"
    echo `find . -name "compile.sh"`
    echo "done with repo $r."
    echo "------------------------"
done

echo
echo "número de programas C- sem erro no oráculo: `ls "$testenv/tests/oracleok" | wc -l`"
echo
echo "número de programas C- com erro no oráculo: `ls "$testenv/tests/oraclenok" | wc -l`"

echo
echo "done prepare group $groupname."
