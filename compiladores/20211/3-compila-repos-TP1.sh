#!/bin/bash
# Has 1 argument - repo name
# Run outside tp1 repos to prepare each repo

testenv=$(pwd)
testenvlex="$testenv/TP1"
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
#    ./tp1_test.sh > tp1_test.log 
    ./compile_lexer.sh > compile_lexer.log
    echo "done with repo $r."
    echo "------------------------"
done

echo
echo "done corrige-repos,  group: $groupname."
