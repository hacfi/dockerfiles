PREFIX = hacfi/
NAME = kong
VERSION = latest

.PHONY: all run build release check test

all: run

run: check
	docker run -d --name cassandra-test -p 7000:7000 -p 7001:7001 -p 7199:7199 -p 9042:9042 -p 9160:9160 cassandra:2.1
	docker run -it --rm --name kong-test --link cassandra-test:cassandra -p 8000:8000 -p 8001:8001 $(PREFIX)$(NAME):$(VERSION) bash

build:
	docker build -t $(PREFIX)$(NAME):$(VERSION) .

release: check
	docker push $(PREFIX)$(NAME):$(VERSION)

check:
	@if ! docker images $(PREFIX)$(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi

test: check
	docker run -d --name cassandra-test -p 7000:7000 -p 7001:7001 -p 7199:7199 -p 9042:9042 -p 9160:9160 cassandra:2.1
	docker run -d --name kong-test --link cassandra-test:cassandra -p 8000:8000 -p 8001:8001 $(PREFIX)$(NAME):$(VERSION) /run.sh
	docker stop cassandra-test kong-test
	docker rm -v cassandra-test kong-test
