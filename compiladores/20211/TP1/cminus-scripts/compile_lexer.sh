#!/bin/bash
# Run inside individual repo 
  
testenv=$(pwd)
srcparser=/src/parser
srclexer=/src/lexer
src=/src/

cd "$testenv$srclexer"
chmod +x "compile.sh"
./compile.sh

#flex "lexer.flex" 
#cc -o lexer "lex.yy.c" -ll

#lexer=`find . -name "lexer" | wc -l"
#if [[ $lexer -eq 0 ]]; then
#    g++ -o lexer "lex.yy.c" -ll
#fi

chmod +x "lexer"
mv "lexer" "$testenv"
cd "$testenv"
echo "lexer compilado."
echo


