# Dockerfile for Elasticsearch 1.4.*

Using [debian:wheezy](https://registry.hub.docker.com/_/debian/), [OpenJDK 7](https://packages.debian.org/de/sid/openjdk-7-jre-headless) and the official [Elasticsearch apt repository for 1.4](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/setup-repositories.html#_apt).


```
git clone git@github.com:hacfi/dockerfiles.git
cd elasticsearch
docker build -t elasticsearch .
docker run -d -p 9200:9200 --name elasticsearch elasticsearch
```
