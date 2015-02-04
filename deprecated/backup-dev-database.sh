#!/usr/bin/bash



#################
# backup-dev-database.sh
#
#
# Backs up the dev database to temp/
#
#  Usage:
# ./backup-dev-database.sh
#################
 

#get the directory this file is in
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd );

#get its parent directory pat
DIR_PARENT=$(dirname $DIR);



#read the config file
source "${DIR%%/}/config-bash.conf";



#run the backup command locally
echo 'starting backup';
mkdir -p "${DIR_PARENT%%/}/temp";
cd "${DIR%%/}"; #this is required since --defaults-file cant take an absolute path without interpreting the path wrong.
#mysqldump -u "${LOCAL_DB_USER}"  "${LOCAL_DB_NAME}" > "${DIR_PARENT%%/}/temp/wp_dev.sql";
mysqldump --defaults-file=config-local-mysql.conf   > ${DIR_PARENT%%/}/temp/wp_dev.sql;
echo 'completed backup';