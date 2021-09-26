#!/bin/bash
# Run inside individual repo 
  
testenv=$(pwd)
srcparser=/src/parser/
srclexer=/src/lexer/
src=/src/

cd $testenv$srclexer
flex lexer.flex 
cc -o lexer lex.yy.c -ll

lexer=`find . -name "lexer"` 
cp $lexer $testenv
cd $testenv

echo "compilado."
echo



