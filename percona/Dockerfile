FROM debian:wheezy

MAINTAINER Philipp Wahala <philipp.wahala@gmail.com>

ENV PERCONA_PW root
ENV DEBCONF_PREFIX percona-server-server-5.6 percona-server-server

RUN groupadd -r mysql && \
    useradd -r -g mysql mysql && \
    apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A && \
    echo "deb http://repo.percona.com/apt wheezy main\ndeb-src http://repo.percona.com/apt wheezy main" > /etc/apt/sources.list.d/percona.list && \
    mv /usr/sbin/policy-rc.d /usr/sbin/policy-rc.d.org && \
    echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d && \
    echo $DEBCONF_PREFIX/root_password password $PERCONA_PW | debconf-set-selections && \
    echo $DEBCONF_PREFIX/root_password_again password $PERCONA_PW | debconf-set-selections && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qy percona-server-server-5.6 percona-server-client-5.6 && \
    rm -rf /var/lib/apt/lists/* && \
    mv /usr/sbin/policy-rc.d.org /usr/sbin/policy-rc.d && \
    rm -rf /var/lib/mysql && \
    mkdir -p /var/lib/mysql

ADD ./my.cnf /etc/mysql/my.cnf

WORKDIR /var/lib/mysql

VOLUME ["/var/lib/mysql"]

COPY docker-entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
