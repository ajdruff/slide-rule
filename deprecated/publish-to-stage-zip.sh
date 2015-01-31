#!/usr/bin/bash

#################
# publish-to-stage.sh
#
# Sends the current dev directories to the remote site
#
#################

#config
staging_file=stage.zip


ssh_connection=$1

zip -r $staging_file config database

# send to remote site
scp $staging_file $ssh_connection:~/

#run commands on remote site
ssh $ssh_connection "bash -s" < ./database/unzip-stage-on-remote.remote.sh

#cleanup
rm $staging_file