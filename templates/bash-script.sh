#!/usr/bin/bash

#################
# template-bash-script.sh
#
#
# Description
#
#  Usage:
# ./template-bash-script.sh
#
#
# @author <user@example.com>
#
#################
 




#get the directory this file is in
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#get its parent directory pat
DIR_PARENT=$(dirname $DIR)

#read common variables for all bash scripts
#source "${DIR%%/}/config-bash.conf";
