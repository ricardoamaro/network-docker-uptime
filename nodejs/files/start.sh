#!/bin/bash

export LOCAL_IP=$(hostname -I)
export IDENTIFIER=${IDENTIFIER:-"build_$(date +%Y_%m_%d_%H%M%S)"}
export REPO=${REPO:-"git@github.com:acquia/network-nodejs-uptime-scanner.git"}
export APP=${APP:-"nodejs"}
export CMD=${CMD:-""}
export DBUSER=${DBUSER:-"someuser"}
export DBPASS=${DBPASS:-"somepass"}
export DBHOST=${DBHOST:-"somehost"}
export GITKEY=${GITKEY:-"somekey"}

cd /data
echo "$GITKEY" > /root/gitkey
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa_example -F /dev/null" git clone $REPO /data

echo
echo "--------------------------STARTING SERVICES-----------------------------------"
echo "USE CTRL+C TO STOP THIS APP"
echo "------------------------------------------------------------------------------"
## supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
npm install
node app.js --dispatcher-url http://localhost:8888
#It will eventually include more arguments
#(like --dispatcher-username, --dispatcher--password, --processor-url etc...)
