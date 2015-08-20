FROM ubuntu:trusty
MAINTAINER Ricardo Amaro <ricardo.amaro_at_acquia.com>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get clean; \
    apt-get update; \
    apt-get -y install unzip vim-tiny git curl wget mc; \
    apt-get clean; \
    apt-get autoclean; \
    apt-get -y autoremove;
