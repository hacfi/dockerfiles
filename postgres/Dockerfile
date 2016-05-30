FROM hacfi/debian:jessie

ENV LANG en_US.utf8
ENV PG_MAJOR 9.5
ENV PG_VERSION 9.5.3-1.pgdg80+1
ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/data

COPY docker-entrypoint.sh /

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      locales && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    groupadd -r postgres --gid=999 && \
    useradd -r -g postgres --uid=999 postgres && \
    curl -SL "https://github.com/tianon/gosu/releases/download/1.9/gosu-$(dpkg --print-architecture)" -o /usr/local/bin/gosu && \
    curl -SL "https://github.com/tianon/gosu/releases/download/1.9/gosu-$(dpkg --print-architecture).asc" -o /usr/local/bin/gosu.asc && \
    export GNUPGHOME="$(mktemp -d)" && \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu && \
    rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true && \
    DEBIAN_FRONTEND=noninteractive apt-get purge -y --auto-remove ca-certificates curl && \
    mkdir /docker-entrypoint-initdb.d && \
    apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 && \
    echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' $PG_MAJOR | tee /etc/apt/sources.list.d/pgdg.list && \
    DEBIAN_FRONTEND=noninteractive apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql-common && \
    sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      postgresql-$PG_MAJOR=$PG_VERSION \
      postgresql-contrib-$PG_MAJOR=$PG_VERSION && \
    rm -rf /var/lib/apt/lists/* && \
    mv -v /usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample /usr/share/postgresql/ && \
    ln -sv ../postgresql.conf.sample /usr/share/postgresql/$PG_MAJOR/ && \
    sed -ri "s!^#?(listen_addresses)\s*=\s*\S+.*!\1 = '*'!" /usr/share/postgresql/postgresql.conf.sample && \
    mkdir -p /var/run/postgresql && \
    chown -R postgres /var/run/postgresql

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["postgres"]
VOLUME ["/var/lib/postgresql/data"]
EXPOSE 5432
