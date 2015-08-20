#!/bin/bash -e

export LOCAL_IP=$(hostname -I)
export IDENTIFIER=${IDENTIFIER:-"build_$(date +%Y_%m_%d_%H%M%S)"}
export REPO=${REPO:-"git@github.com:acquia/network-nodejs-uptime-scanner.git"}
export APP=${APP:-"nodejs"}
export CMD=${CMD:-""}
export DBUSER=${DBUSER:-"someuser"}
export DBPASS=${DBPASS:-"somepass"}
export DBHOST=${DBHOST:-"somehost"}
export GIT_KEY=${GIT_KEY:-"somekey"}

cd /data
echo "$GIT_KEY" > /root/gitkey
chmod 600 /root/gitkey
git clone $REPO /data || exit 1

echo
echo "--------------------------STARTING SERVICES-----------------------------------"
echo "USE CTRL+C TO STOP THIS APP"
echo "------------------------------------------------------------------------------"

npm install --production
node app.js --dispatcher-url http://localhost:8888
#It will eventually include more arguments
#(like --dispatcher-username, --dispatcher--password, --processor-url etc...)
