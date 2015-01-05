FROM debian:wheezy

MAINTAINER Philipp Wahala <philipp.wahala@gmail.com>

RUN apt-get update && \
    apt-get install -y wget && \
    wget --no-check-certificate -O - https://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add - && \
    echo 'deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main' >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y elasticsearch openjdk-7-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

CMD ["/usr/share/elasticsearch/bin/elasticsearch"]

ADD config/elasticsearch.yml /usr/share/elasticsearch/elasticsearch.yml

EXPOSE 9200 9300

VOLUME ["/data"]

WORKDIR /data

