#!/bin/bash

export DRUSH="/.composer/vendor/drush/drush/drush"
export LOCAL_IP=$(hostname -I)
export IDENTIFIER=${IDENTIFIER:-"build_$(date +%Y_%m_%d_%H%M%S)"}
export REPO=${REPO:-"http://git.drupal.org/project/drupal.git"}
export APP=${APP:-"api"}
export CMD=${CMD:-""}
export DBUSER=${DBUSER:-"someuser"}
export DBPASS=${DBPASS:-"somepass"}
export DBHOST=${DBHOST:-"somehost"}
export REDIS=${REDIS:-"somehost"}
export GITKEY=${GITKEY:-"somekey"}




case "$APP" in
  api)
    PAYLOAD_CODE_URL
    ;;

  processor)
    ;;

  dispatcher)
    ;;

  *)
    echo "Invalid APP name provided"
    exit 1
esac


echo "$GITKEY" > /root/gitkey
GIT_SSH_COMMAND="ssh -i /root/gitkey -F /dev/null" git clone $REPO /var/www/html



echo
echo "--------------------------STARTING SERVICES-----------------------------------"
echo "USE CTRL+C TO STOP THIS APP"
echo "------------------------------------------------------------------------------"
supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
