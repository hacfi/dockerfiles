FROM debian:jessie

ENV KONG_VERSION 0.5.4

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      curl \
      dnsmasq \
      lua5.1 \
      netcat \
      openssl \
      sudo && \
    curl -L https://github.com/Mashape/kong/releases/download/${KONG_VERSION}/kong-${KONG_VERSION}.jessie_all.deb -o /tmp/kong.deb && \
    dpkg -i /tmp/kong.deb

COPY run.sh /run.sh
COPY kong.yml /etc/kong/kong.yml.template

CMD ["/run.sh"]
VOLUME ["/etc/kong/"]
EXPOSE 8000 8001
