PREFIX = hacfi/
NAME = postgres
VERSION = latest

.PHONY: all run build release check test

all: run

run: check
	docker run -it --rm -p 5432:5432 $(PREFIX)$(NAME):$(VERSION)

build:
	docker build -t $(PREFIX)$(NAME):$(VERSION) .

release: check
	docker push $(PREFIX)$(NAME):$(VERSION)

remove: check
	docker rmi $(PREFIX)$(NAME):$(VERSION)

check:
	@if ! docker images $(PREFIX)$(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "Image '$(PREFIX)$(NAME):$(VERSION)' is not yet built. Please run 'make build'."; false; fi

test: check
	docker run --rm $(PREFIX)$(NAME):$(VERSION) bash -c "postgres --version | grep 9.5."
