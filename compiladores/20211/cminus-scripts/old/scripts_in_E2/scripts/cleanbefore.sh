#!/bin/bash

user=$(whoami)
testenv=$(pwd)
srcparser=/src/parser/
srclexer=/src/lexer/
feedback=/feedback
inputs=/feedback/inputs/
outputs=/feedback/outputs/
oracle=/feedback/oracle/
oracleok=/feedback/oracleok/
oraclenok=/feedback/oraclenok/
passou=/feedback/passou/
naopassou=/feedback/naopassou/
mydiff=/feedback/diffc/
mydiffTP=/feedback/TP/
mydiffTN=/feedback/TN/
mydiffFP=/feedback/FP/
mydiffFN=/feedback/FN/

rm -r "$testenv$outputs"
rm -r "$testenv$passou"
rm -r "$testenv$naopassou"
rm -r "$testenv$mydiff"
rm -r "$testenv$mydiffTP"
rm -r "$testenv$mydiffTN"
rm -r "$testenv$mydiffFP"
rm -r "$testenv$mydiffFN"
