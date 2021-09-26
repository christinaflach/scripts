#!/bin/zsh

cd 01-Lexer-10-24-2020-04-42-27-last/

mydirs=$(ls) 

# The function total_files reports a total number of files for a given directory. 
function total_files {
        find $1 -type f | wc -l
}

# The function total_directories reports a total number of directories
# for a given directory. 
function total_directories {
        find $1 -type d | wc -l
}

#echo $mydirs
#echo "antes do for ..."



for x in $mydirs; do 
	echo -n $x; 
	cd $x;
	echo -n "Directories to be included:"
	echo " "
	total_directories $x
	cd ..
done

# para cada folder em dir
# pegar arquivo lexer.lex, fazer compile.sh
# pegar .\lexer e executar


cd ..

