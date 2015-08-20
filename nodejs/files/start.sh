#!/bin/bash

export DRUSH="/.composer/vendor/drush/drush/drush"
export LOCAL_IP=$(hostname -I)
export IDENTIFIER=${IDENTIFIER:-"build_$(date +%Y_%m_%d_%H%M%S)"}
export REPO=${REPO:-"git@github.com:acquia/network-nodejs-uptime-scanner.git"}
export APP=${APP:-"API"}
export CMD=${CMD:-""}
export DBUSER=${DBUSER:-"someuser"}
export DBPASS=${DBPASS:-"somepass"}
export DBHOST=${DBHOST:-"somehost"}
export GITKEY=${GITKEY:-"somekey"}

cd /data
echo "$GITKEY" > /root/gitkey
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa_example -F /dev/null" git clone $REPO /data

#if [ ! -f /var/www/html/sites/default/settings.php ]; then
  #GIT CLONE
  #MAKE STUFF WORK FOR APPX
  #sleep 3s
#else
#fi

echo
echo "--------------------------STARTING SERVICES-----------------------------------"
echo "USE CTRL+C TO STOP THIS APP"
echo "------------------------------------------------------------------------------"
supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
