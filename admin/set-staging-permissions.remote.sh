#################
# set-staging-permissions.remote.sh
# 
#
# Run this script only as input to a remote ssh session
#
# Sets Permissions on remote site
# Usage:
# ssh me@example.com "bash -s" < "./set-staging-permissions.remote.sh"
# @author <andrew@nomstock.com>
#################

##config
## you can't include the config-bash.sh file here since it won't be found on remote server
STAGE_DIR_PATH=~/stage; #start with tilde,no trailing slash
HTML_DIRNAME=public_html #name only , no path, e.g.: public_html
PROD_DIR_PATH=~; #tilde only, no trailing slash

echo '#############################';

## Test Concatenation of paths here
# dir "${STAGE_DIR_PATH%%/}/${HTML_DIRNAME}/"; #test
# dir "${STAGE_DIR_PATH%%/}/"; #test


echo '##### Locking Down Staging Permissions ######';
echo '...'
##staging
chmod 600  "${STAGE_DIR_PATH%%/}/${HTML_DIRNAME}/wp-config.php"
chmod 600  "${STAGE_DIR_PATH%%/}/config/wp-config.php"
chmod 600  "${STAGE_DIR_PATH%%/}/config/wp-config-db.php"
chmod 644 "${STAGE_DIR_PATH%%/}/${HTML_DIRNAME}/.htaccess"
chmod 644 "${STAGE_DIR_PATH%%/}/${HTML_DIRNAME}/wp-admin/.htaccess"
chmod 644 "${STAGE_DIR_PATH%%/}/${HTML_DIRNAME}/index.php"
find "${STAGE_DIR_PATH%%/}/${HTML_DIRNAME}/" -type d -exec chmod 755 {} \;
find "${STAGE_DIR_PATH%%/}/${HTML_DIRNAME}/" -type f -exec chmod 644 {} \;


echo '##### Locking Down Production Permissions ######';
echo '...'
##production
chmod 600  "${PROD_DIR_PATH%%/}/${HTML_DIRNAME}/wp-config.php"
chmod 600  "${PROD_DIR_PATH%%/}/config/wp-config.php"
chmod 600  "${PROD_DIR_PATH%%/}/config/wp-config-db.php"
chmod 644 "${PROD_DIR_PATH%%/}/${HTML_DIRNAME}/.htaccess"
chmod 644 "${PROD_DIR_PATH%%/}/${HTML_DIRNAME}/wp-admin/.htaccess"
chmod 644 "${PROD_DIR_PATH%%/}/${HTML_DIRNAME}/index.php"
find "${PROD_DIR_PATH%%/}/${HTML_DIRNAME}/" -type d -exec chmod 755 {} \;
find "${PROD_DIR_PATH%%/}/${HTML_DIRNAME}/" -type f -exec chmod 644 {} \;


#provide message back to user

echo '##### Permissions Complete ######';
pwd;
echo '#####  Stage Contains #######';
dir;
echo '#############################';