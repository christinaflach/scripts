#!/bin/bash

# This bash script is used to backup a user's home directory to /tmp/.

user=$(whoami)
input=/Users/christinavonflach/01-lexer/01-Lexer-10-24-2020-04-42-27-last/
output=/Users/$user/01-lexer/

# The function total_files reports a total number of files for a given directory. 
function total_files {
        find $1 -type f | wc -l
}

# The function total_directories reports a total number of directories
# for a given directory. 
function total_directories {
        find $1 -type d | wc -l
}

function echo_dirs {

	echo -n "Files to be included:"
	total_files $input
	echo -n "Directories to be included:"
	total_directories $input
}

function flex_p {
	echo "in flex: $1/src/lexer";
	cd "$1/src/lexer";
	if [ -f lexer.lex ]; then
        	flex lexer.lex
	else
		if [ -f lexer.l ]; then
	        	flex lexer.l
		else
			if [ -f "Makefile" ]; then
				echo "Makefile"
			else 
				echo pwd
				echo "arquivo não encontrado";
			fi
		fi
	fi
	echo "finished for $1"
}

echo "1. Details about files in $input"
cd $input
echo_dirs
ls

echo "3. Run compile in each dir"
cd $input
mydirs=$(ls)

for x in $mydirs; do
        echo $x;
        cd "$input$x";
	if [ -f "compile.sh" ]; then
		chmod +x compile.sh
		./compile.sh 2> /dev/null
        else
		cd "$input$x/src/lexer";
		if [ -f "compile.sh" ]; then
			chmod +x compile.sh
			./compile.sh 2> /dev/null
		else
                        echo "    >>> compile.sh nao encontrado"
                        if [ -f "Makefile" ]; then
                                echo "Makefile"
                        else
                        	if [ -f "makefile" ]; then
                                	echo "makefile"
                        	else
                                	echo "    >>> makefile não encontrado";
                        	fi
                	fi
		fi
	fi
done

echo "END"

