#!/usr/bin/bash

#################
# update-staging-database.sh
#
#
# Sends the current dev directories to the remote site
#
#  Usage:
# configure config-bash.conf
# update-staging-db.sh <local_mysql_username> 
# Example
# ./update-staging-db.sh root clients_glandscapedesign_wp user@example.com mysql_username
#
#
# @author <andrew@nomstock.com>
#
#################
 




#get the directory this file is in
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#get its parent directory pat
DIR_PARENT=$(dirname $DIR)

#read the global config file
source "${DIR%%/}/config-bash.conf";

######################
#
# Backup Dev Database
#
######################

#make sure there is a temp directory to dump to
mkdir -p "${DIR_PARENT%%/}/temp";

#change to the current directory
#this is required since --defaults-file cant take an absolute path without interpreting the path wrong.
cd "${DIR%%/}"; 
command="mysqldump --defaults-file=config-mysql-dev.conf ${DEV_DB_NAME} > ${DIR_PARENT%%/}/temp/wp_dev.sql"
eval $command;

echo "MySQL Dev Database backup complete, located at ${DIR_PARENT%%/}/temp/wp_dev.sql";



##upload it to remote mysql over a ssh tunnel
#
#ref: https://gist.github.com/scy/6781836


## setup tunnel
ssh -f -o ExitOnForwardFailure=yes -L "${LOCAL_SSH_FORWARDING_PORT}":localhost:3306 "${SSH_CONNECTION}" sleep 10;

########################
#
# Restore Dev To Stage
#
########################
echo "Replacing Staging Database with Dev Database, and then running the convert-to-stage script against it.";

#pipe different sql files to the mysql command, which will run them against the local port, which is being forwarded to the remote port
cd "${DIR%%/}"; 
command="cat ${DIR_PARENT%%/}/temp/wp_dev.sql ${DIR%%/}/config-sql.sql ${DIR%%/}/convert-dev-to-stage.sql ${DIR%%/}/convert-database-to-new-domain.sql | mysql --defaults-file=config-mysql-stage.conf -P ${LOCAL_SSH_FORWARDING_PORT}  -h 127.0.0.1 --database=${STAGE_DB_NAME};rm -r ${DIR_PARENT%%/}/temp/wp_dev.sql";
#echo "command  = $command";
eval $command;

echo "Staging database data has been replaced with the data in the dev database";