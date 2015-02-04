#!/usr/bin/bash

#################
# load-staging-database.inc.sh
#
#
# Loads Staging Database with New Data
#
# Never use standalone - always include in a another bash file - see load-staging-database-with-live/dev.sh for an example
#
#
# @author <andrew@nomstock.com>
#
#################
 
######################
#
# Setup Tunnel if Needed
#
######################

if [[ "${SOURCE_DATABASE_IS_REMOTE}" == true ]] || [[ "${DEST_DATABASE_IS_REMOTE}" == true ]]; then 
## setup tunnel
echo 'Creating SSH Tunnel to secure remote MySQL connection';
ssh -f -o ExitOnForwardFailure=yes -L "${LOCAL_SSH_FORWARDING_PORT}":localhost:3306 "${SSH_CONNECTION}" sleep 10;

fi


######################
#
# Backup Source Database
#
######################

echo "Making a Copy of Database ${SOURCE_DB_NAME} to ${SOURCE_BACKUP_FILE}" ;

#make sure there is a temp directory to dump to
#mkdir -p "${DIR_PARENT%%/}/temp";

#change to the current directory
#this is required since --defaults-file cant take an absolute path without interpreting the path wrong.
cd "${DIR%%/}"; 


if [[ "${SOURCE_DATABASE_IS_REMOTE}" == true ]]; then 
echo 'MySQL connecting to source database over SSH tunnel';
    #backup live database
    command="mysqldump --defaults-file=${SOURCE_MYSQL_DEFAULTS_FILE} -P ${LOCAL_SSH_FORWARDING_PORT}  -h 127.0.0.1 ${SOURCE_DB_NAME} > ${SOURCE_BACKUP_FILE}";
  
  
else
echo 'MySQL connecting to source database over local connection';
command="mysqldump --defaults-file=${SOURCE_MYSQL_DEFAULTS_FILE} ${SOURCE_DB_NAME} > ${SOURCE_BACKUP_FILE}";


fi

#echo "command  = $command";
eval $command;

########################
#
# Update Stage
#
########################
echo "Updating Staging Database";

#pipe different sql files to the mysql command, which will run them against the local port, which is being forwarded to the remote port
cd "${DIR%%/}"; 
if [[ "${DEST_DATABASE_IS_REMOTE}" == true ]]; then 

echo 'MySQL connecting to destination database over SSH tunnel';

command="cat ${SOURCE_BACKUP_FILE} ${SQL_SETTINGS_FILE} ${SQL_CONVERSION_FILE} ${DIR%%/}/convert-database-to-new-domain.sql | mysql --defaults-file=${DEST_DEFAULTS_FILE} -P ${LOCAL_SSH_FORWARDING_PORT}  -h 127.0.0.1 --database=${DEST_DB_NAME};rm -r ${SOURCE_BACKUP_FILE}";
else
echo 'MySQL connecting to destination database over local connection';
command="cat ${SOURCE_BACKUP_FILE} ${SQL_SETTINGS_FILE} ${SQL_CONVERSION_FILE} ${DIR%%/}/convert-database-to-new-domain.sql | mysql --defaults-file=${DEST_DEFAULTS_FILE} --database=${DEST_DB_NAME};rm -r ${SOURCE_BACKUP_FILE}";

fi

#echo "command  = $command";
eval $command;


echo "Staging database has been updated";