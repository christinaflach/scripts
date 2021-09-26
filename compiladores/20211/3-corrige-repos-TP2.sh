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
    cp "$testenvlex/cminus-scripts/tp2_test.sh" "$repotestenv/"
    ./tp2_test.sh > tp2_test.log 
    echo "done with repo $r."
    echo "------------------------"
done

echo
echo "done corrige-repos,  group: $groupname."
