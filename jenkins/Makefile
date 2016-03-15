PREFIX = hacfi/
NAME = jenkins
VERSION = latest

.PHONY: all run build release check test

all: run

run: check
	docker run -it --rm -p 8080:8080 $(PREFIX)$(NAME):$(VERSION)

build:
	docker build -t $(PREFIX)$(NAME):$(VERSION) .

release: check
	docker push $(PREFIX)$(NAME):$(VERSION)

remove: check
	docker rmi $(PREFIX)$(NAME):$(VERSION)

check:
	@if ! docker images $(PREFIX)$(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "Image '$(PREFIX)$(NAME):$(VERSION)' is not yet built. Please run 'make build'."; false; fi

test: check
	docker run -d --name jenkins-test $(PREFIX)$(NAME):$(VERSION)
	docker run -it --link jenkins-test:jenkins --rm $(PREFIX)$(NAME):$(VERSION) sh -c 'until nc -z $$JENKINS_PORT_8080_TCP_ADDR 8080; do sleep 1; done && curl -I "$$JENKINS_PORT_8080_TCP_ADDR:8080"'
	docker stop jenkins-test
	docker rm -v jenkins-test
