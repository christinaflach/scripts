#!/bin/bash

user=$(whoami)
workingdir=$(pwd)
srcparser=/src/parser/
srclexer=/src/lexer/
feedback=/feedback
inputs=/inputs/
outputs=/outputs/
oracle=/oracle/
oracleok=/oracleok/
oraclenok=/oraclenok/
passou=/passou/
naopassou=/naopassou/
mydiff=/diffc/
mydiffTP=/TP/
mydiffTN=/TN/
mydiffFP=/FP/
mydiffFN=/FN/

echo "cd feedback"
cd "$workingdir$feedback"
echo "$(pwd)"

echo "cleaning feedback dirs ... "

rm -r "$outputs"
rm -r "$passou"
rm -r "$naopassou"
rm -r "$mydiff"
rm -r "$mydiffTP"
rm -r "$mydiffTN"
rm -r "$mydiffFP"
rm -r "$mydiffFN"

