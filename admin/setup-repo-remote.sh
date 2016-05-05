#!/usr/bin/bash

#################
# load-staging-database-with-dev.sh
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

# use cat + no echo 
# cat ${DIR%%/}/commands.inc.sh | ssh ${SSH_CONNECTION} 'bash -s';
# git init;
#or
# use source + echo . this allows you to source in local scripts  
# cat ${DIR%%/}/commands.inc.sh | ssh ${SSH_CONNECTION} 'bash -s';
# echo 'git init';

echo 'git init' | ssh ${SSH_CONNECTION} 'bash -s';

#run commands to setup the remote configuration (email name,etc)
source ${DIR%%/}/setup-repo-remote-git-config.inc.sh | ssh ${SSH_CONNECTION} 'bash -s';



echo 'Creating New Repo on remote server and uploading post-receive script';

#Upload the post receive hook functions
scp ${DIR%%/}/post-receive.sh ${SSH_CONNECTION}:.git/hooks/post-receive;
scp ${DIR%%/}/post-receive-functions.sh ${SSH_CONNECTION}:.git/hooks/post-receive-functions.sh;

#Upload config file so the post-receive script can use it.
scp ${DIR%%/}/config-bash.conf ${SSH_CONNECTION}:.git/hooks/config-bash.conf;

#upload the exclude file
scp ${DIR%%/}/git-info-exclude.conf ${SSH_CONNECTION}:.git/info/exclude;

#create the live and master branches
#must do this after git configuration and exclude files are uploaded
source ${DIR%%/}/setup-repo-remote-branches.inc.sh | ssh ${SSH_CONNECTION} 'bash -s';




echo 'chmod 700 .git/hooks/post-receive' | ssh ${SSH_CONNECTION} 'bash -s';
echo 'chmod 700 .git/hooks/config-bash.conf' | ssh ${SSH_CONNECTION} 'bash -s';
echo 'Completed remote repo creation';