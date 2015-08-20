FROM ricardoamaro/uptime-base:latest
MAINTAINER Ricardo Amaro <ricardo.amaro_at_acquia.com>
ENV DEBIAN_FRONTEND noninteractive

# Install Nginx.
RUN apt-get update && \
  apt-get install -y nginx php5 && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx;

RUN apt-get clean; \
  apt-get autoclean; \
  apt-get -y autoremove;

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Install supervisor
COPY ./files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./files/start.sh /start.sh

RUN chmod 755 /start.sh
WORKDIR /var/www/html
EXPOSE 80 443
CMD ["/bin/bash", "/start.sh"]

# Define default command.
#CMD ["nginx"]
