#!/bin/bash -e

export LOCAL_IP=$(hostname -I)
export IDENTIFIER=${IDENTIFIER:-"build_$(date +%Y_%m_%d_%H%M%S)"}
export REPO=${REPO:-"git@github.com:acquia/network-nodejs-uptime-scanner.git"}
export APP=${APP:-"scanner"}
export CMD=${CMD:-""}
export DBUSER=${DBUSER:-"someuser"}
export DBPASS=${DBPASS:-"somepass"}
export DBHOST=${DBHOST:-"somehost"}
export GIT_KEY=${GIT_KEY:-"somekey"}
export DISPATCHER_IP=${PROCESSOR_IP:-""}
export DISPATCHER_PORT=${PROCESSOR_PORT:-"80"}
export PROCESSOR_IP=${PROCESSOR_IP:-""}
export PROCESSOR_PORT=${PROCESSOR_PORT:-"80"}
export AUTH_USER=${AUTH_USER:-"someuser"}
export AUTH_PASS=${AUTH_PASS:-"somepass"}

cd /data
echo "$GIT_KEY" > /root/gitkey
chmod 600 /root/gitkey
git clone $REPO /data || exit 1

echo
echo "--------------------------STARTING SERVICES-----------------------------------"
echo "USE CTRL+C TO STOP THIS APP ( $APP ) http://${LOCAL_IP} "
echo "------------------------------------------------------------------------------"

npm install --production
node app.js --dispatcher-url http://${DISPATCHER_IP}:${DISPATCHER_PORT} \
--dispatcher-user ${AUTH_USER} --dispatcher-pass ${AUTH_PASS} \
--processor-url http://${PROCESSOR_IP}:${PROCESSOR_PORT} \
--processor-user ${AUTH_USER} --processor-pass ${AUTH_PASS}
