########################
#
# MySQL Tunnel Over SSH Examples
# 
# Usage: 
# ./mysql-port-forward-example.sh user@example.com my_mysql_username
#
#
#@author <andrew@nomstock.com>
#########################




SSH_CONNECTION=$1 # e.g.: user@example.com
DB_USER=$2 # e.g.: my_username
LOCAL_PORT=5555 # e.g.: my_username

#get the directory this file is in
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#get its parent directory pat
DIR_PARENT=$(dirname $DIR)





#Example 1 - Use a local file to run commands on remote mysql server over ssh
#ref: https://gist.github.com/scy/6781836
ssh -f -o ExitOnForwardFailure=yes -L 5555:localhost:3306 user@example.com sleep 10;
mysql -u my_mysql_username -p -P 5555  -h 127.0.0.1 < "${DIR%%/}/sandbox.sql";

exit;

#Example 2 - Run a string as a command
#ref: https://gist.github.com/scy/6781836
ssh -f -o ExitOnForwardFailure=yes -L 5555:localhost:3306 user@example.com sleep 10;
mysql -u my_mysql_username -p -P 5555  -h 127.0.0.1 -e 'SHOW DATABASES;'


#Example 3 - Using Script Arguments
#
#ref: https://gist.github.com/scy/6781836
ssh -f -o ExitOnForwardFailure=yes -L "${LOCAL_PORT}":localhost:3306 "${SSH_CONNECTION}" sleep 10;
mysql -u "${DB_USER}" -p -P "${LOCAL_PORT}"  -h 127.0.0.1 -e 'SHOW DATABASES;'


exit;


