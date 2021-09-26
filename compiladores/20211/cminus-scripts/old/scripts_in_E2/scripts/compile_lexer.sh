#!/bin/bash
# Run inside individual repo 
  
user=$(whoami)
testenv=$(pwd)
srcparser=/src/parser/
srclexer=/src/lexer/
src=/src/

comp=`find $testenv$srclexer -name "compile.sh"`
cd $testenv$srclexer
sh $comp

lexer=`find . -name "lexer"` 
cp $lexer $testenv
cd $testenv

echo

