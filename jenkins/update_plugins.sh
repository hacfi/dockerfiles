#!/bin/bash

UPDATE_LIST=$(java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://127.0.0.1:8080/ list-plugins | grep -e ')$' | awk '{ print $1 }')

if [ ! -z "${UPDATE_LIST}" ]; then
  echo Updating Jenkins Plugins: ${UPDATE_LIST}
  java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://127.0.0.1:8080/ install-plugin ${UPDATE_LIST}
  java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://127.0.0.1:8080/ safe-restart
fi
