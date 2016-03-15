FROM hacfi/java:8-jdk

ENV JENKINS_VERSION 1.653
ENV JENKINS_SHA 068171bfa327916764d8dbd42ab9e638665848c6
ENV JENKINS_HOME /var/jenkins_home
ENV JENKINS_SLAVE_AGENT_PORT 50000
ENV JENKINS_UC https://updates.jenkins-ci.org
ENV COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log

COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy
COPY jenkins.sh /usr/local/bin/jenkins.sh
COPY plugins.sh /usr/local/bin/plugins.sh
COPY update_plugins.sh /usr/local/bin/update_plugins.sh

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      curl \
      git \
      netcat \
      zip && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -d "$JENKINS_HOME" -u 1000 -m -s /bin/bash jenkins && \
    curl -fL https://github.com/krallin/tini/releases/download/v0.9.0/tini-static -o /bin/tini && \
    chmod +x /bin/tini && \
    echo "fa23d1e20732501c3bb8eeeca423c89ac80ed452 /bin/tini" | sha1sum -c - && \
    curl -fL http://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war -o /usr/share/jenkins/jenkins.war && \
    echo "$JENKINS_SHA /usr/share/jenkins/jenkins.war" | sha1sum -c - && \
    chown -R jenkins "$JENKINS_HOME" /usr/share/jenkins/ref

USER jenkins

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
VOLUME /var/jenkins_home
EXPOSE 8080 50000
