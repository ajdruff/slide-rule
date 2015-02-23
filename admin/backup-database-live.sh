#!/usr/bin/bash

#################
# backup-database-live.sh
#
#
# Backsup the live database
#
#  Usage:
# ./backup-database-live.sh
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

#read common variables for all conversion scripts
source "${DIR%%/}/config-bash-advanced.conf";


#config
SOURCE_DATABASE_IS_REMOTE="${LIVE_DATABASE_IS_REMOTE}";

SOURCE_MYSQL_DEFAULTS_FILE="${LIVE_MYSQL_DEFAULTS_FILE}";#name of mysql --defaults-file containing username and passwords (in the same directory as this file)
SOURCE_BACKUP_FILE="${LIVE_BACKUP_FILE}"; #absolute file path to where we stash the source db and where we restore it from
SOURCE_DB_NAME="${LIVE_DB_NAME}";

source "${DIR%%/}/backup-database.inc.sh";