#!/bin/bash

user=$(whoami)
lexer01=$(pwd)
input=/Users/christinavonflach/01-lexer/01-Lexer-10-24-2020-04-42-27-last/
inputs=/Users/christinavonflach/01-lexer/01-Lexer-10-24-2020-04-42-27-last/inputs/
outputs=/Users/christinavonflach/01-lexer/01-Lexer-10-24-2020-04-42-27-last/outputs/
withall=/Users/christinavonflach/01-lexer/01-Lexer-10-24-2020-04-42-27-last/withall/

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
	total_files $withall
	echo -n "Directories to be included:"
	total_directories $withall
}

echo
echo "1. Details about files in $withall"
cd $withall
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
cd $withall
mydirs=$(ls)
echo $mydirs
echo
for x in $mydirs; do
    echo "$withall$x";
    cd "$withall$x";
	if [ -f "run.sh" ]; then
	    chmod +x run.sh
        if [[ ! -e "tests" ]]; then
            mkdir "$withall$x/tests";
        fi
        for t in $mytests; do
            echo "$withall$x";
            echo $t
            run.sh "$inputs$t" "$withall$x/tests/$t.lex"
            diff "$outputs$t.lex" "$withall$x/tests/$t.lex" > "$withall$x/tests/$t.res"
        done
    else
	    cd "$withall$x/src/lexer";
	    if [ -f "run.sh" ]; then
	        chmod +x run.sh
            if [[ ! -e "tests" ]]; then
                mkdir "$withall$x/tests";
            fi
            for t in $mytests; do
                echo "$withall$x";
                echo $t
                run.sh $inputs$t "$withall$x/tests/$t.lex"
                diff "$outputs$t.lex" "$withall$x/tests/$t.lex" > "$withall$x/tests/$t.res"
            done
         fi
    fi
done

echo
echo "END"

