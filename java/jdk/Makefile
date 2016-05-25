PREFIX = hacfi/
NAME = java
VERSION = 8-jdk

.PHONY: all run build release check test

all: run

run: check
	docker run -it --rm $(PREFIX)$(NAME):$(VERSION) bash

build:
	docker build -t $(PREFIX)$(NAME):$(VERSION) .

release: check
	docker push $(PREFIX)$(NAME):$(VERSION)

remove: check
	docker rmi $(PREFIX)$(NAME):$(VERSION)

check:
	@if ! docker images $(PREFIX)$(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "Image '$(PREFIX)$(NAME):$(VERSION)' is not yet built. Please run 'make build'."; false; fi

test: check
	docker run --rm $(PREFIX)$(NAME):$(VERSION) bash -c "java -version 2>&1 | grep 1.8.0_"
