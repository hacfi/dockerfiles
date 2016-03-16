PREFIX = hacfi/
NAME = kong
VERSION = latest

.PHONY: all run build release check test

all: run

run: check
	docker run -d --name cassandra-test -p 9042:9042 cassandra:2.2.4
	docker run -it --rm --name kong-test --link cassandra-test:cassandra -p 7946:7946 -p 7946:7946/udp -p 8000:8000 -p 8001:8001 -p 8443:8443 --security-opt seccomp:unconfined $(PREFIX)$(NAME):$(VERSION)

build:
	docker build -t $(PREFIX)$(NAME):$(VERSION) .

release: check
	docker push $(PREFIX)$(NAME):$(VERSION)

remove: check
	docker rmi $(PREFIX)$(NAME):$(VERSION)

check:
	@if ! docker images $(PREFIX)$(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "Image '$(PREFIX)$(NAME):$(VERSION)' is not yet built. Please run 'make build'."; false; fi

test: check
	docker run -d --name cassandra-test -p 9042:9042 cassandra:2.2.4
	docker run -d --name kong-test --link cassandra-test:cassandra -p 7946:7946 -p 7946:7946/udp -p 8000:8000 -p 8001:8001 -p 8443:8443 --security-opt seccomp:unconfined $(PREFIX)$(NAME):$(VERSION)
	docker stop cassandra-test kong-test
	docker rm -v cassandra-test kong-test
