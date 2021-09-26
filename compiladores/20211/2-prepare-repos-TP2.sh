#!/bin/bash
# Has 1 argument - repo name
# Run outside tp2 repos to prepare each repo

testenv=$(pwd)
testenvlex="$testenv/TP2"
groupname=$1
grouptestenv="$testenvlex/$groupname" 
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
    rm -r "$repotestenv$feedback"
    mkdir "$repotestenv$feedback"

    echo "copiando /tests para /feedback"
    cp -r "$testenvlex/cminus-tests/inputs" "$repotestenv$feedback/"
    cp -r "$testenvlex/cminus-tests/oracle" "$repotestenv$feedback/"
    cp -r "$testenvlex/cminus-tests/oracleok" "$repotestenv$feedback/"
    cp -r "$testenvlex/cminus-tests/oraclenok" "$repotestenv$feedback/"
    cp "$testenvlex/cminus-tests/README.md" "$repotestenv$feedback/"

    echo "copiando /scripts"
    cp -r "$testenvlex/cminus-scripts" "$repotestenv/"

#   echo "buscando compile.sh"
#   echo `find . -name "compile.sh"`
    echo "done with repo $r."
    echo "------------------------"
done

echo
#echo "número de programas C- sem erro no oráculo: `ls "$testenvlex/tests/oracleok" | wc -l`"
echo
#echo "número de programas C- com erro no oráculo: `ls "$testenvlex/tests/oraclenok" | wc -l`"

echo
echo "done prepare group $groupname."
