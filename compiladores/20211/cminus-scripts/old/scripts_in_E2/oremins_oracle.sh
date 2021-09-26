#!/bin/bash

user=$(whoami)
testenv=$(pwd)
outputs=/tests/oracle/
outputsf=/tests/oraclef/
outputsc=/tests/oraclec/

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
	total_files "$testenv$outputs"
	echo -n "Directories to be included:"
	total_directories $testenv 
}

echo
echo "1. Details about files in "
echo "$testenv$outputs"
cd "$testenv$outputs"
total_files "$testenv$outputs"
ls
cd $testenv
mkdir "$testenv$outputsf"
mkdir "$testenv$outputsc"
echo

echo "2. Run rmnl in each file"
cd "$testenv$outputs"
mytests=$(ls)
echo $mytests

echo
cd $testenv
for t in $mytests; do
    echo $t
    ./orem < "$testenv$outputs$t" > "$testenv$outputsf$t"
    ./oins < "$testenv$outputsf$t" > "$testenv$outputsc$t"
done

rm -R "$testenv$outputsf"

echo
echo "END"
