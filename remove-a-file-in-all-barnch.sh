#!/bin/bash
# set -e
#pass the file path of from github repo like ./filename.txt & repo url while executing script 
##clone the repository that passes as a input while execting
git clone $2
##get the folder name from git url
FOLDER_NAME=$(echo $2 | cut -d'/' -f5 | cut -d'.' -f1)
##chnage to that folder
cd $FOLDER_NAME
##count total number of branch
NO_LINES=$(git branch -r | wc -l)
NO_BRANCH_COUNT=$(($NO_LINES - 1))
# NO_BRANCH_COUNT=$(git branch -r | wc -l)
echo "number of branches in this repository is '$NO_BRANCH_COUNT"
echo "path of workflow is $1"
echo "project url is $2"

##a first two branch repitative thats why starting from line 3
COUNT=2
while [ $COUNT -le $(($NO_BRANCH_COUNT + 1)) ]     
do
	echo "Welcone to $(($COUNT-1)) branch"  
    BRANCH_NAME=$(git branch -r | cut -d'/' -f2 | head -$COUNT | tail -1)   
    echo "target branch is $BRANCH_NAME"
    git checkout $BRANCH_NAME
    rm -fv $1 
    git add .
    git commit -m "add files requires for GitHub action"
    git push
	(( COUNT++ ))
done
