FROM hacfi/debian:jessie

ENV LANG C.UTF-8

RUN { \
      echo '#!/bin/bash'; \
      echo 'set -e'; \
      echo; \
      echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home && \
    chmod +x /usr/local/bin/docker-java-home

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JAVA_VERSION 8u72
ENV JAVA_DEBIAN_VERSION 8u72-b15-1~bpo8+1
ENV CA_CERTIFICATES_JAVA_VERSION 20140324

RUN echo 'deb http://httpredir.debian.org/debian jessie-backports main' | tee /etc/apt/sources.list.d/jessie-backports.list && \
    DEBIAN_FRONTEND=noninteractive apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      bzip2 \
      ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION" \
      openjdk-8-jdk="$JAVA_DEBIAN_VERSION" \
      unzip \
      xz-utils && \
    [ "$JAVA_HOME" = "$(docker-java-home)" ] && \
    /var/lib/dpkg/info/ca-certificates-java.postinst configure && \
    rm -rf /var/lib/apt/lists/*
