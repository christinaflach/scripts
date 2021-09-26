#!/bin/bash

user=$(whoami)
lexer01=/Users/christinavonflach/01-lexer/
input=/Users/christinavonflach/01-lexer/01-Lexer-10-24-2020-04-42-27-last/
inputs=/Users/christinavonflach/01-lexer/01-Lexer-10-24-2020-04-42-27-last/inputs/
outputs=/Users/christinavonflach/01-lexer/01-Lexer-10-24-2020-04-42-27-last/outputs/
withall=/Users/christinavonflach/01-lexer/01-Lexer-10-24-2020-04-42-27-last/withall/
withoutrun=/Users/christinavonflach/01-lexer/01-Lexer-10-24-2020-04-42-27-last/withoutrun/


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
				echo "  Makefile [Y]"
			else 
				echo pwd
				echo "  Makefile [N]";
			fi
		fi
	fi
	echo "finished for $1"
}

echo
echo "1. Details about files in $input"
cd $input
echo_dirs
ls

echo
echo "2. Run run.sh in each dir"
cd $inputs
mytests=$(ls)
echo $mytests
echo
cd $outputs
myoutputs=$(ls)
echo $myoutputs
echo
cd $input
mydirs=$(ls)
mkdir $withoutrun

for x in $mydirs; do
    echo $x;
    cd "$input$x";
	if [ -f "run.sh" ]; then
		chmod +x run.sh
        for t in $mytests; do
            echo $x
            echo
            run.sh $t "$t.lex"
            diff "$outputs$t.lex" "$t.lex" > "$t.res"
        done
    else
		cd "$input$x/src/lexer";
		if [ -f "run.sh" ]; then
			chmod +x run.sh
            for t in $mytests; do
              echo $x
              echo
              run.sh $t "$t.lex"
              diff "$outputs$t.lex" "$t.lex" > "$t.res"
            done
		else
            echo "   run.sh não encontrado";
             mv "$input$x" "$withoutrun$x"
        fi
	fi
done

echo
echo "END"

