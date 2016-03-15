#!/bin/bash

set -e

if [ "$1" = 'redis-server' -a "$(id -u)" = '0' ]; then
	chown -R redis .
	exec gosu redis "$BASH_SOURCE" "$@"
fi

exec "$@"
