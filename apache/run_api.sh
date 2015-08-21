#!/bin/bash

# Check if we are a member of the "docker" group or have root powers
USERNAME=$(whoami)
TEST=$(groups $USERNAME | grep -c '\bdocker\b')
if [ $TEST -eq 0 ];
then
  if [ `whoami` != root ]; then
    echo "Please run this script as root or using sudo"
    exit 1
  fi
fi

TAG="ricardoamaro/uptime-apache"
APP="api"

docker run --rm -i -t  \
  -e "GIT_KEY=$(cat ~/keys/${APP})" \
	-e "APP=$APP" \
	-e "REDIS_HOST=" \
	-e "REDIS_PORT=" \
	-e "AUTH_USER=" \
	-e "AUTH_PASS=" \
	${TAG}
