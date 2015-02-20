#!/usr/bin/bash

#################
# setup.sh
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

#remote repo
command "${DIR%%/}/setup-repo-remote.sh";
#local repo
command "${DIR%%/}/setup-repo-local.sh";
