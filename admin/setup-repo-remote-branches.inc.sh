#!/bin/bash

#################
# setup-repo-remote.sh
#
#
# Creates a remote repo and adds the post-receive script.
#
#  Usage:
#  either run this script locally or include in setup-repo-remote.sh
#  
# This script is executed when its output is piped through an ssh connection
# Example: source ${DIR%%/}/setup-repo-remote.inc.sh | ssh ${SSH_CONNECTION} 'bash -s';
# @author <andrew@nomstock.com>
#

#get the directory this file is in
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#get its parent directory pat
DIR_PARENT=$(dirname $DIR)

#read common variables for all bash scripts
source "${DIR%%/}/config-bash.conf";


#first we add a dummy file, then we delete it, then we commit. This is a workaround to allowing us to create
#a repo that is essentially empty, but allows for our initial local push to live to be successful, otherwise it would fail telling you that there is no live branch.
echo "git checkout -b live";
echo "echo 'initialized repo' > ${LIVE_DIR_PATH}/${HTML_DIRNAME}/slide-rule";
echo "git add .";
echo "rm ${LIVE_DIR_PATH}/${HTML_DIRNAME}/slide-rule";
echo "git commit -m 'initialized repo'";

echo "git checkout -b master";
echo "git checkout live";
