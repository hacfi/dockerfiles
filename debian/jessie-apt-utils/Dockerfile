FROM hacfi/debian:jessie

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils \
    && rm -rf /var/lib/apt/lists/*
