PREFIX = hacfi/
NAME = debian
VERSION = jessie

.PHONY: all run build release check test

all: run

run: check
	docker run -it --rm $(PREFIX)$(NAME):$(VERSION) bash

build:
	docker pull debian:jessie
	docker tag debian:jessie $(PREFIX)$(NAME):$(VERSION)

release: check
	docker push $(PREFIX)$(NAME):$(VERSION)

remove: check
	docker rmi $(PREFIX)$(NAME):$(VERSION)

check:
	@if ! docker images $(PREFIX)$(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "Image '$(PREFIX)$(NAME):$(VERSION)' is not yet built. Please run 'make build'."; false; fi

test: check
	docker run --rm $(PREFIX)$(NAME):$(VERSION) bash -c "apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y curl && curl https://google.com"
