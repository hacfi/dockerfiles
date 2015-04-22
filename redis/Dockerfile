FROM hacfi/debian:jessie

ENV REDIS_VERSION 2.8.19
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-2.8.19.tar.gz
ENV REDIS_DOWNLOAD_SHA1 3e362f4770ac2fdbdce58a5aa951c1967e0facc8

COPY docker-entrypoint.sh /

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y adduser curl \
    && groupadd -r redis \
    && useradd -r -g redis redis \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -SL "https://github.com/tianon/gosu/releases/download/1.3/gosu-$(dpkg --print-architecture)" -o /usr/local/bin/gosu  \
    && curl -SL "https://github.com/tianon/gosu/releases/download/1.3/gosu-$(dpkg --print-architecture).asc" -o /usr/local/bin/gosu.asc  \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && buildDeps='gcc libc6-dev make' \
    && set -x \
    && apt-get install -y $buildDeps --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /usr/src/redis \
    && curl -sSL "$REDIS_DOWNLOAD_URL" -o redis.tar.gz \
    && echo "$REDIS_DOWNLOAD_SHA1 *redis.tar.gz" | sha1sum -c - \
    && tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
    && rm redis.tar.gz \
    && make -C /usr/src/redis \
    && make -C /usr/src/redis install \
    && rm -r /usr/src/redis \
    && apt-get purge -y --auto-remove $buildDeps \
    && mkdir /data \
    && chown redis:redis /data

VOLUME /data
WORKDIR /data

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 6379
CMD ["redis-server"]