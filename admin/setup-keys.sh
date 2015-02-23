#!/usr/bin/bash

#################
# setup-keys.sh
#
#
# Uploads Public Key and Sets proper permissions for PPK access
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


echo 'Copying Public Key to Remote Server';
echo 'You will be prompted for the SSH Passwored 3 times. Once it is uploaded, you will no longer be prompted.';

#make the remote .ssh directory
echo "mkdir ${LIVE_DIR_PATH}/.ssh" | ssh ${SSH_CONNECTION} 'bash -s';

#upload the key securely to the server
scp ${LOCAL_SSH_PUBLIC_KEY_PATH} ${SSH_CONNECTION}:${LIVE_DIR_PATH}/.ssh/id_rsa.pub

#add the key to the authorize keys file and set permissions
command="\
cat ${LIVE_DIR_PATH}/.ssh/id_rsa.pub >> ${LIVE_DIR_PATH}/.ssh/authorized_keys;\
rm ${LIVE_DIR_PATH}/.ssh/id_rsa.pub;\
chmod  500 ${LIVE_DIR_PATH}/.ssh;\
chmod 400 ${LIVE_DIR_PATH}/.ssh/authorized_keys\
";


echo ${command} | ssh ${SSH_CONNECTION} 'bash -s';

echo "Completed Key Upload";