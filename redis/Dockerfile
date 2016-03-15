FROM hacfi/debian:jessie

COPY docker-entrypoint.sh /

RUN apt-get update -qq -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      adduser \
      curl && \
    groupadd -r redis && \
    useradd -r -g redis redis && \
    curl -SL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture)" -o /usr/local/bin/gosu && \
    curl -SL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture).asc" -o /usr/local/bin/gosu.asc && \
    export GNUPGHOME="$(mktemp -d)" && \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu && \
    rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true && \
    buildDeps='gcc libc6-dev make' && \
    set -x && \
    apt-get install -y --no-install-recommends $buildDeps && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /usr/src/redis && \
    curl -sSL "http://download.redis.io/releases/redis-2.8.24.tar.gz" -o redis.tar.gz && \
    echo "636efa8b522dfbf7f3dba372237492c11181f8e0 *redis.tar.gz" | sha1sum -c - && \
    tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 && \
    rm redis.tar.gz && \
    make -C /usr/src/redis && \
    make -C /usr/src/redis install && \
    rm -r /usr/src/redis && \
    apt-get purge -y --auto-remove $buildDeps && \
    mkdir /data && \
    chown redis:redis /data

WORKDIR /data

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["redis-server"]
VOLUME /data
EXPOSE 6379
