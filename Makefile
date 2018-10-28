all: build

.PHONY: build
build:
	docker build .
