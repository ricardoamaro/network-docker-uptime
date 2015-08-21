#!/bin/bash

export LOCAL_IP=$(hostname -I)
export IDENTIFIER=${IDENTIFIER:-"build_$(date +%Y_%m_%d_%H%M%S)"}
export APP=${APP:-"api"}
export CMD=${CMD:-""}
export DBUSER=${DBUSER:-"someuser"}
export DBPASS=${DBPASS:-"somepass"}
export DBHOST=${DBHOST:-"somehost"}
export REDIS=${REDIS:-"somehost"}
export GIT_KEY=${GIT_KEY:-"somekey"}

REPO_BASE="git@github.com:acquia"
case "$APP" in
  api)
    REPO="$REPO_BASE/network-uptime-api.git"
    ;;

  processor)
    REPO="$REPO_BASE/network-uptime-processor.git"
    ;;

  dispatcher)
    REPO="$REPO_BASE/network-uptime-dispatcher.git"
    ;;

  *)
    echo "Invalid APP name provided" 1>&2
    exit 1
esac

cd /var/www
rm -rf /var/www/html/*

echo "$GIT_KEY" > /root/gitkey
chmod 600 /root/gitkey
git clone $REPO /var/www/html || exit 1

echo
echo "--------------------------STARTING SERVICES-----------------------------------"
echo "USE CTRL+C TO STOP THIS APP ( $APP ) http://${LOCAL_IP} "
echo "------------------------------------------------------------------------------"
supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
