PREFIX = hacfi/
NAME = debian
VERSION = jessie-slim

.PHONY: all run build release check test

all: run

run: check
	docker run -it --rm $(PREFIX)$(NAME):$(VERSION) bash

build:
	docker build -f "Dockerfile.1" -t $(PREFIX)$(NAME):$(VERSION)-build .

	docker create --name $(NAME)-$(VERSION)-build $(PREFIX)$(NAME):$(VERSION)-build
	docker export $(NAME)-$(VERSION)-build > build.tar

	docker rm -v $(NAME)-$(VERSION)-build
	docker rmi $(PREFIX)$(NAME):$(VERSION)-build

	docker build -f "Dockerfile.2" -t $(PREFIX)$(NAME):$(VERSION) .
	@rm build.tar

	@echo "\n$(PREFIX)$(NAME):$(VERSION) built successfully!"

release: check
	docker push $(PREFIX)$(NAME):$(VERSION)

remove: check
	docker rmi $(PREFIX)$(NAME):$(VERSION)

check:
	@if ! docker images $(PREFIX)$(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "Image '$(PREFIX)$(NAME):$(VERSION)' is not yet built. Please run 'make build'."; false; fi

test: check
	docker run --rm $(PREFIX)$(NAME):$(VERSION) bash -c "apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl && curl https://google.com"
