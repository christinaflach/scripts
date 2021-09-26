#!/bin/bash
# Has 1 argument - repo name
# Run outside tp1 repos to prepare each repo

testenvlex=$(pwd)
groupname=$1
grouptestenv="$testenvlex/$groupname" 

cd "$grouptestenv"
echo "Dir: $grouptestenv"
repos=$(ls)

for r in $repos; do
    echo "Repo name: $r"
    repotestenv="$grouptestenv/$r"
    echo "Dir: $repotestenv"
    cd  "$repotestenv"
    cp -r "$testenvlex/scripts/" "$repotestenv"
    ./tp1_test.sh
done
echo
echo "done prepare group $groupname."
