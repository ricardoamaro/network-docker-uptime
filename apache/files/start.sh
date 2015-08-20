#!/bin/bash

export DRUSH="/.composer/vendor/drush/drush/drush"
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
    REPO="$REPO_BASE/network-uptime-dispatchr.git"
    ;;

  *)
    echo "Invalid APP name provided" 1>&2
    exit 1
esac

cd /var/www
[ -e /var/www/html ] && rm -r /var/www/html
echo "$GIT_KEY" > /root/gitkey

GIT_SSH_COMMAND="ssh -i /root/gitkey -F /dev/null" git clone $REPO /var/www/html
R=$?
if [ $R != 0 ]; then
    echo "Git failed to clone $REPO" 1>&2
    exit $R
fi

echo
echo "--------------------------STARTING SERVICES-----------------------------------"
echo "USE CTRL+C TO STOP THIS APP"
echo "------------------------------------------------------------------------------"
supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
