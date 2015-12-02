# Based on: https://github.com/nginxinc/docker-nginx/blob/master/Dockerfile
FROM debian:wheezy
MAINTAINER Pierre-Eric Marchandet <pemarchandet@gmail.com>

# Add NGinx official repository
RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/debian/ wheezy nginx" >> /etc/apt/sources.list
ENV NGINX_VERSION 1.8.0-1~wheezy

# Update system
ENV DEBIAN_FRONTEND noninteractive
RUN groupadd -r www && \
    useradd -r -g www www && \
    apt-get update && \
    apt-get upgrade -qq -y --no-install-recommends && \
    apt-get install -qq -y --no-install-recommends \
      ca-certificates nginx=${NGINX_VERSION} && \
    apt-get autoremove -qq -y && \
    apt-get autoclean -qq -y && \
    rm -rf /var/lib/apt/lists/*

# Forward request and error logs to Docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Configuration files
COPY nginx.conf /etc/nginx/nginx.conf
COPY conf host-specific /etc/nginx/conf/

# Mount points for volumes
RUN mkdir -p /etc/certs /var/cache/nginx /var/tmp

# Source
# Raw source files exposed as HTTP and HTTPS
COPY raw /www/
# Project files exposed as HTTPS
COPY  bundle/programs/web.browser/*.js \
      bundle/programs/web.browser/*.css \
      bundle/programs/web.browser/packages \
      bundle/programs/web.browser/app \
      /www/

# Ensure proper rights on static assets
RUN chown -R www:www /www /var/cache /var/tmp

# Launch NGinx
COPY startNginx.sh /startNginx.sh
RUN chmod u+x /startNginx.sh
CMD ["/startNginx.sh"]
