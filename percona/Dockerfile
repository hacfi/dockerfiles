FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y

RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
ADD ./percona.list /etc/apt/sources.list.d/percona.list
ADD ./00percona.pref /etc/apt/preferences.d/00percona.pref
RUN apt-get update

RUN apt-get install -y percona-server-server-5.6 percona-server-client-5.6

ADD ./my.cnf /etc/mysql/my.cnf

ADD ./setup_mysql_root.sh /tmp/setup_mysql_root.sh
RUN /bin/sh /tmp/setup_mysql_root.sh

EXPOSE 3306

CMD ["/usr/sbin/mysqld"]
