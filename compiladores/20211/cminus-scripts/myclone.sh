#!/bin/bash

file='users.txt'
i=1
while read line; do
#echo "Line No. $i: $line"
nome="tp1-$line.git"
url="https://github.com/mata61-ufba-20211/$nome"
echo $nome
echo $url
git clone $url
i=$((i+1))
done < $file
