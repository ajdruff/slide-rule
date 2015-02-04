#!/usr/bin/bash

#################
# push-to-stage-files.sh
#
#
# Uses Rsync to Push Dev files to the remote site
#
#  Usage:
# ./push-to-stage.sh
#################



#get the directory this file is in
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#get its parent directory pat
DIR_PARENT=$(dirname $DIR)

#read the config file
source "${DIR%%/}/config-bash.conf";

#config 
DRY_RUN=false; ## set to true to add --dry-run
PREVENT_LOGIN="${STAGE_PREVENT_LOGIN}"; ## set to true to prevent login and admin access


#######################
#
# Dry Run Option
#
########################

if [[ "${DRY_RUN}" == true ]]; then 

dry_run_option=" --dry-run ";

fi

#######################
#
# Rsync to target
#
########################


command="rsync  -azvH --delete  ${dry_run_option} ${DIR_PARENT%%/}/${HTML_DIRNAME}  -e ssh ${SSH_CONNECTION}:${STAGE_DIR_PATH}";

eval $command;


#######################
#
# Dry Run Messaging
#
########################
if [[ "${DRY_RUN}" == true ]]; then 
echo '##############################################';
echo '########### Rsync Executed as a Dry Run ######';
echo '##############################################';
echo '########### Rsync Command Used: ######';

echo $command;
echo '##############################################';
fi

#######################
#
# Ovewrite .htaccess to /wp-admin/
########################
if [[ "${PREVENT_LOGIN}" == true ]]; then 
command="scp ${DIR%%/}/templates/public_html/wp-admin/wp-admin-stage.htaccess.htaccess ${SSH_CONNECTION}:${STAGE_DIR_PATH}/${HTML_DIRNAME}/wp-admin/.htaccess"

eval  $command;
fi
#######################
#
# Ovewrite .htaccess
########################
if [[ "${PREVENT_LOGIN}" == true ]]; then 
command="scp ${DIR%%/}/templates/public_html/stage.htaccess ${SSH_CONNECTION}:${STAGE_DIR_PATH}/${HTML_DIRNAME}/.htaccess"
echo 'prevnting login';
eval  $command;
fi
#######################
#
# Update Permisssions
#
########################
command="cat ${DIR%%/}/config-bash.conf ${DIR%%/}/set-staging-permissions.sh |ssh ${SSH_CONNECTION} bash -s"

eval $command;




#############################