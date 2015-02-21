#!/usr/bin/bash

#################
# setup-repo-local.sh
#
#
# Overwrites the Staging Database with the Dev Database 
#
#  Usage:
# ./load-staging-database-with-dev.sh
#
#
# @author <andrew@nomstock.com>
#
#################
 




#get the directory this file is in
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#get its parent directory pat
DIR_PARENT=$(dirname $DIR)

#read common variables for all bash scripts
source "${DIR%%/}/config-bash.conf";

#git remote add origin ssh://user@example.com/home/username/.git
cd ${LOCAL_REPO_PATH}

git clone ssh://${SSH_CONNECTION}${LIVE_DIR_PATH}/.git ${LOCAL_REPO_PATH}/


#copy the web template into the repo directory
command "${DIR%%/}/setup-home.sh;


git add .

git commit -a -m 'initial commit'
git push origin master