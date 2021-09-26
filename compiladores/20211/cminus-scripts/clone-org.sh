#!/bin/bash
# Has 1 argument - org name
# Run outside groups to prepare each group repo


ORGANIZATION=$1
echo $1
for i in `curl -s https://api.github.com/orgs/$ORGANIZATION/repos?per_page=200 | grep html_url | awk 'NR%2 == 0'| cut -d ':' -f 2-3 | tr -d '",'`; 
do  
    echo $i;
    git clone $i.git;  
done



