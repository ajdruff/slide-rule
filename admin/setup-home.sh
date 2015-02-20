#!/usr/bin/bash

#################
# setup-home.sh
#
#
# Copies over the configured template into the home directory
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



LOCAL_REPO_PATH="${LOCAL_REPO_PATH}2"

#git remote add origin ssh://user@example.com/home/username/.git
cd ${LOCAL_REPO_PATH}

echo "${LOCAL_REPO_PATH}";

#copy the template into the repo directory
command="cp  -rv ${SITE_TEMPLATE_PATH}/* ${LOCAL_REPO_PATH}"
eval $command;

command="cp  -v ${SITE_TEMPLATE_PATH}/.gitignore ${LOCAL_REPO_PATH}"
eval $command;
command="cp  -v ${SITE_TEMPLATE_PATH}/.gitattributes ${LOCAL_REPO_PATH}"
eval $command;