#################
#
# Unzips the staging archive on the remote site
# This script is intended to run on the remote site via publish-to-stage.sh
#
#################

#config
subdomain_subdirectory_path=stage
staging_file=stage.zip
site_files="config public_html"

#make sure staging directory exisets
mkdir -p ~/$subdomain_subdirectory_path;

#move archive to staging directory
mv $staging_file ~/$subdomain_subdirectory_path/;

#must change to subdirectory or resulting zip will overwrite all live files
cd ~/$subdomain_subdirectory_path/;

#remove the files that are there
rm -r $site_files


#unzip, forcing overwrite
unzip -o $staging_file;

#cleanup

rm $staging_file


#provide message back to user
echo '#############################';
echo '##### Staging Complete ######';
echo '##### Staging Directory: ####';
pwd;
echo '#####  Stage Contains #######';
dir;
echo '#############################';