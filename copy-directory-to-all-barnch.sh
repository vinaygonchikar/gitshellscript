#!/bin/bash
# set -xe
#file path shoulbe found out from git-bash terminal
#this shellscript to be executed from git-bash terminal only
#enter existing folder name & path to be deleted
#enter the new folder path in ur laptop to copy & push to  github
FOLDER_ADD=/c/Users/0030AC744/Desktop/copyfolder
#enter the url of git repository
GIT_URL=https://github.com/vinaygonchikar/sample-spring-microservices.git
#stop feeding input from here
#####################################################################################################
git clone $GIT_URL
##get the folder name from git url
FOLDER_NAME=$(echo $GIT_URL | cut -d'/' -f5 | cut -d'.' -f1)
##chnage to that folder
cd $FOLDER_NAME
##count total number of branch
NO_LINES=$(git branch -r | wc -l)
NO_BRANCH_COUNT=$(($NO_LINES - 1))
# NO_BRANCH_COUNT=$(git branch -r | wc -l)
echo "number of branches in this repository is '$NO_BRANCH_COUNT"
echo "new folder path going to add to all branch is $FOLDER_ADD"
echo "project url is $GIT_URL"
##a first two branch repitative thats why starting from line 3
COUNT=2
while [ $COUNT -le $(($NO_BRANCH_COUNT + 1)) ]     
do
	echo "Welcone to $(($COUNT-1)) branch"  
    BRANCH_NAME=$(git branch -r | cut -d'/' -f2 | head -$COUNT | tail -1)   
    echo "target branch is $BRANCH_NAME"
    git checkout $BRANCH_NAME
    PRESENT_PATH=$(pwd)
    echo "working directory path is $PRESENT_PATH"
    cp -R $FOLDER_ADD $PRESENT_PATH
    git add .
    git commit -m "add files requires for GitHub action"
    git push
	(( COUNT++ ))
done
