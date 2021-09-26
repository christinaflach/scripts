#!/bin/bash
# Argumento: dirname

user=$(whoami)
testenv=$(pwd)
srcparser=/src/parser/
srclexer=/src/lexer/
feedback=/feedback
inputs=/feedback/inputs/
outputs=/feedback/outputs/
outputsc=/feedback/outputsc/
oracle=/feedback/oracle/
oraclec=/feedback/oraclec/
oracleok=/feedback/oracleok/
oraclenok=/feedback/oraclenok/
passou=/feedback/passou/
naopassou=/feedback/naopassou/
mydiff=/feedback/diffc/
mydiffTP=/feedback/TP/
mydiffTN=/feedback/TN/
mydiffFP=/feedback/FP/
mydiffFN=/feedback/FN/

cd $testenv$1
myfiles=$(ls)
for t in $myfiles; do
    name=$(basename $t .in.out)
    mv $testenv$t $testenv$name.out
done

