#!/bin/bash
# Has 1 argument - repo name
# Run outside tp1 repos to prepare each repo

testenvlex=$(pwd)
tp1testenv="$testenvlex/TP1"
groupname=$1
testenv=$(pwd)
grouptestenv="$testenv/$groupname" 
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
    cp -r "$testenvlex/tests/inputs" "$repotestenv$feedback/"
    cp -r "$testenvlex/tests/oracle" "$repotestenv$feedback/"
    cp -r "$testenvlex/tests/oracleok" "$repotestenv$feedback/"
    cp -r "$testenvlex/tests/oraclenok" "$repotestenv$feedback/"
    cp "$testenvlex/tests/README.md" "$repotestenv$feedback/"

    echo "copiando /scripts"
    cp -r "$testenvlex/scripts/*" .

    echo "buscando compile.sh"
    echo `find . -name "compile.sh"`
    echo "done with repo $r."
    echo "------------------------"
done

echo
echo "número de programas C- sem erro no oráculo: `ls "$testenvlex/tests/oracleok" | wc -l`"
echo
echo "número de programas C- com erro no oráculo: `ls "$testenvlex/tests/oraclenok" | wc -l`"

echo
echo "done prepare group $groupname."
