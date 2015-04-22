PREFIX = hacfi/
NAME = debian
VERSION = jessie-curl

.PHONY: all run build release check test

all: run

run: check
	docker run -t -i --rm $(PREFIX)$(NAME):$(VERSION) bash

build:
	docker build -t $(PREFIX)$(NAME):$(VERSION) .

release: check
	docker push $(PREFIX)$(NAME)

check:
	@if ! docker images $(PREFIX)$(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi

test: check
	docker run --rm $(PREFIX)$(NAME):$(VERSION) curl https://google.com
