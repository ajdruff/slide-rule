#!/usr/bin/bash

#################
# publish-to-stage.sh
#
#
# Sends the current dev directories to the remote site
#
#  Usage:
# configure config-bash.cfg
# ./publish-to-stage.sh username@example.com
#################
 
ssh_connection=$1

#get the directory this file is in
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#get its parent directory pat
DIR_PARENT=$(dirname $DIR)

#read the config file
source "${DIR%%/}/config-bash.cfg";


##replace with rsync
## concatenation of paths , see http://stackoverflow.com/a/11226444/3306354
# rsync  -azvHn  --delete  "${DIR_PARENT%%/}/${HTML_DIRNAME}"  -e ssh $ssh_connection:$staging_dir_path


#run commands on remote site
ssh $ssh_connection "bash -s" < "${DIR%%/}/set-staging-permissions.remote.sh"
