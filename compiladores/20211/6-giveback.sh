#!/bin/bash
# Has 1 argument - repo name
# Run outside tp1 repos to prepare each repo

testenv=$(pwd)
testenvlex="$testenv/TP1"
groupname=$1
grouptestenv="$testenvlex/$groupname"

cd "$grouptestenv"
repos=$(ls)

for r in $repos; do
    echo "Repo name: $r"
    repotestenv="$grouptestenv/$r"
    echo "Dir: $repotestenv"
    cd  "$repotestenv"
    `git add "$repotestenv/tp1_test.log" `
    `git add "$repotestenv/src/lexer/lexer.flex"`
    `git commit -am "Correção do TP1"`
    `git push --set-upstream origin feedback` 
    echo "done with repo $r."
    echo "------------------------"
done
