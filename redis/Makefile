PREFIX = hacfi/
NAME = redis
VERSION = 2.8.24

.PHONY: all run build release check test

all: run

run: check
	docker run -it --rm -p 6379:6379 $(PREFIX)$(NAME):$(VERSION) bash

build:
	docker build -t $(PREFIX)$(NAME):$(VERSION) .

release: check
	docker push $(PREFIX)$(NAME):$(VERSION)

remove: check
	docker rmi $(PREFIX)$(NAME):$(VERSION)

check:
	@if ! docker images $(PREFIX)$(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "Image '$(PREFIX)$(NAME):$(VERSION)' is not yet built. Please run 'make build'."; false; fi

test: check
	docker run -d --name redis-test $(PREFIX)$(NAME):$(VERSION) redis-server
	docker run -it --link redis-test:redis --rm $(PREFIX)$(NAME):$(VERSION) sh -c 'exec redis-cli -h "$$REDIS_PORT_6379_TCP_ADDR" -p "$$REDIS_PORT_6379_TCP_PORT" set test yep'
	docker run -it --link redis-test:redis --rm $(PREFIX)$(NAME):$(VERSION) sh -c 'exec redis-cli -h "$$REDIS_PORT_6379_TCP_ADDR" -p "$$REDIS_PORT_6379_TCP_PORT" get test'
	docker stop redis-test
	docker rm -v redis-test

test-interactive: check
	docker run -d --name redis-test $(PREFIX)$(NAME):$(VERSION) redis-server
	docker run -it --link redis-test:redis --rm $(PREFIX)$(NAME):$(VERSION) sh -c 'exec redis-cli -h "$$REDIS_PORT_6379_TCP_ADDR" -p "$$REDIS_PORT_6379_TCP_PORT"'
	docker stop redis-test
	docker rm -v redis-test
