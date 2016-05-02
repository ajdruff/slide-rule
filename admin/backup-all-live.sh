#!/usr/bin/bash

#################
# backup-all-live.sh
#
#
#
#
# @author <andrew@nomstock.com>
#
#################
 




#get the directory this file is in
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#get its parent directory pat
DIR_PARENT=$(dirname $DIR)

#read the config file
source "${DIR%%/}/config-bash.conf";

#read the advanced config file
source "${DIR%%/}/config-bash-advanced.conf";



#files
command "${DIR%%/}/backup-files-live.sh";
#database
command "${DIR%%/}/backup-database-live.sh";

#tar database file to file location.
gzip -c  ${LIVE_BACKUP_FILE} > ${LOCAL_BACKUP_DIR}/${DOMAIN}-${ARCHIVE_FILE_ENDING}.sql.gz


