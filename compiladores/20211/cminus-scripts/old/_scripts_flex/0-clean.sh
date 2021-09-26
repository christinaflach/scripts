#!/bin/bash

# This bash script is used to backup a user's home directory to /tmp/.

user=$(whoami)
input=/Users/christinavonflach/01-lexer/01-Lexer-10-24-2020-04-42-27-last/
output=/Users/$user/01-lexer/
#mydirs=$(ls) /Users/christinavonflach/01-lexer/01-Lexer-10-24-2020-04-42-27-last/

echo "2. Clean each dir"
cd $input
mydirs=$(ls)

echo $mydirs
for x in $mydirs; do
        echo $input$x;
       	cd $input$x;
       	if [ -f src/lexer/lex.yy.c ]; then
                rm $input$x/src/lexer/lex.yy.c
        fi
done


