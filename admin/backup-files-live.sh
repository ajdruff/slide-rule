#!/usr/bin/bash

#################
# backup-files-live.sh
#
#
# Backs up the live files to local
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


#config 
DRY_RUN=false; ## set to true to add --dry-run
ZIP=true; ## ZIP=true will result in .zip compression. False will result in tar.gz compression
RSYNC=true; ## if RSYNC = true, no compression, just rsyncs with remote.


#######################
#
# Rsync to target
#
########################

#LIVE_DIR_PATH="stage/public_html2/wp-content/themes/twentyfourteen/";

mkdir -p ${LOCAL_BACKUP_DIR};



#######################
#
# COMPRESSION TYPE
#
########################


compress_option="tar -zcvf ";
compress_file_suffix="tar.gz";

if [[ "${ZIP}" == true ]]; then 

compress_option="zip -r ";
compress_file_suffix="zip";




fi


#######################
#
# Dry Run Option
#
########################
output_dry_run="> /dev/null"; # alternative "| wc -c"
output_without_dry_run=">  ${LOCAL_BACKUP_DIR}/${DOMAIN}-${ARCHIVE_FILE_ENDING}.${compress_file_suffix}";

if [[ "${DRY_RUN}" == true ]]; then 




dry_run_option=" --dry-run ";
output=${output_dry_run};
else



dry_run_option="";
output=${output_without_dry_run};
fi






#######################
#
# RSYNC or Zip/Tar
#
########################

if [[ "${RSYNC}" == true ]]; then 

mkdir -p ${LOCAL_BACKUP_DIR}/${DOMAIN};
command="rsync  -azvH   --delete  ${dry_run_option}   -e ssh ${SSH_CONNECTION}:${LIVE_DIR_PATH} ${LOCAL_BACKUP_DIR}/${DOMAIN}";
command_without_dryrun="rsync  -azvH   --delete  -e ssh ${SSH_CONNECTION}:${LIVE_DIR_PATH} ${LOCAL_BACKUP_DIR}/${DOMAIN}";
else

command="ssh -n  ${SSH_CONNECTION} \"${compress_option}  - ${LIVE_DIR_PATH}\" ${output}";

#we need the actual command that will be run so we can display it even if its not used.
command_without_dryrun="ssh -n  ${SSH_CONNECTION} \"${compress_option}  - ${LIVE_DIR_PATH}\" ${output_without_dry_run}";

fi






eval $command;




#eval $command;



#######################
#
# Dry Run Messaging
#
########################
if [[ "${DRY_RUN}" == true ]]; then 
echo '##############################################';
echo '########### Backup Executed as a Dry Run ######';
echo '##############################################';
echo '########### Backup Command Used: ######';

echo $command_without_dryrun;
echo '##############################################';
fi

#######################
