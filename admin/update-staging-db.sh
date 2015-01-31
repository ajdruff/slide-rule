#!/usr/bin/bash

#################
# update-staging-database.sh
#
#
# Sends the current dev directories to the remote site
#
#  Usage:
# configure config-bash.cfg
# update-staging-db.sh <local_mysql_username> 
# Example
# ./update-staging-db.sh root clients_glandscapedesign_wp user@example.com mysql_username
#
#
# @author <andrew@nomstock.com>
#
#################
 
#config 
LOCAL_SSH_FORWARDING_PORT=5555 # local forwarding port for ssh
SSH_CONNECTION=gscape@174.36.179.67 # e.g. : user@example.com
REMOTE_DB_USER=gscape_wp # e.g.: gscape_wp
REMOTE_DB_NAME=gscape_wp_stage # e.g.: gscape_wp
LOCAL_DB_USER=root  # e.g.: root
LOCAL_DB_NAME=clients_glandscapedesign_wp;



#get the directory this file is in
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#get its parent directory pat
DIR_PARENT=$(dirname $DIR)

#read the config file
source "${DIR%%/}/config-bash.cfg";


##export the dev database
echo "Please enter your local MySQL password for username ${LOCAL_DB_USER}"
mkdir -p "${DIR_PARENT%%/}/temp";
mysqldump -u "${LOCAL_DB_USER}" -p "${LOCAL_DB_NAME}" > "${DIR_PARENT%%/}"/temp/wp_stage.sql

echo "local MySQL backup complete, located at ${DIR_PARENT%%/}/temp/wp_stage.sql";


echo "Please enter your Remote MySQL password for username ${REMOTE_MYSQL_USERNAME}";

##upload it to remote mysql over a ssh tunnel
#
#ref: https://gist.github.com/scy/6781836


## setup tunnel
ssh -f -o ExitOnForwardFailure=yes -L "${LOCAL_SSH_FORWARDING_PORT}":localhost:3306 "${SSH_CONNECTION}" sleep 10;


echo "Replacing Staging Database with Dev Database, and then running the convert-to-stage script against it.";

#pipe different sql files to the mysql command, which will run them against the local port, which is being forwarded to the remote port
cat "${DIR_PARENT%%/}/temp/wp_stage.sql" "${DIR%%/}/convert-to-stage.sql" | mysql -u "${REMOTE_DB_USER}" -p -P "${LOCAL_SSH_FORWARDING_PORT}"  -h 127.0.0.1 --database="${REMOTE_DB_NAME}"; 
echo "Staging Database has been updated";


#< "${DIR%%/}/sandbox.sql" 