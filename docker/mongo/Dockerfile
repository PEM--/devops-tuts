# Based on: https://github.com/docker-library/mongo/blob/d5aca073ca71a7023e0d4193bd14642c6950d454/3.0/Dockerfile
FROM debian:wheezy
MAINTAINER Pierre-Eric Marchandet <pemarchandet@gmail.com>

# Update system
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get upgrade -y -qq --no-install-recommends && \
    apt-get install -y -qq --no-install-recommends apt-utils && \
    apt-get install -y -qq --no-install-recommends \
      ca-certificates curl psmisc apt-utils && \
    apt-get autoremove -y -qq && \
    apt-get autoclean -y -qq && \
    rm -rf /var/lib/apt/lists/*

# Grab gosu for easy step-down from root
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    curl -sS -o /usr/local/bin/gosu -L "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" && \
    curl -sS -o /usr/local/bin/gosu.asc -L "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" && \
    gpg --verify /usr/local/bin/gosu.asc && \
    rm /usr/local/bin/gosu.asc && \
    chmod +x /usr/local/bin/gosu

# Install MongoDB
ENV MONGO_MAJOR 3.0
ENV MONGO_VERSION 3.0.6
RUN groupadd -r mongodb && \
    useradd -r -g mongodb mongodb && \
    apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 492EAFE8CD016A07919F1D2B9ECBEC467F0CEB10 && \
    echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/$MONGO_MAJOR main" > /etc/apt/sources.list.d/mongodb-org.list && \
    apt-get update && \
    apt-get install -y -qq --no-install-recommends \
      mongodb-org=$MONGO_VERSION \
      mongodb-org-server=$MONGO_VERSION \
      mongodb-org-shell=$MONGO_VERSION \
      mongodb-org-mongos=$MONGO_VERSION \
      mongodb-org-tools=$MONGO_VERSION && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/mongodb && \
    mv /etc/mongod.conf /etc/mongod.conf.orig && \
    apt-get autoremove -y -qq && \
    apt-get autoclean -y -qq && \
    rm -rf /var/lib/apt/lists/* && \
    # Prepare environment for Mongo daemon: Use a Docker Volume container
    mkdir -p /db && chown -R mongodb:mongodb /db

# Launch Mongo
COPY mongod.conf /etc/mongod.conf
USER mongodb
CMD ["mongod", "-f", "/etc/mongod.conf"]
