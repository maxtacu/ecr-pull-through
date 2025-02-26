.PHONY: build run kind-create docker-build
COMMIT_SHA=$(shell git rev-parse --short HEAD)

build:
	go build -o bin/mutation-webhook cmd/*.go

run:
	go run cmd/

kind-create:
	kind create cluster --config kind.yaml

docker-build:
	docker build -t ghcr.io/maxtacu/ecr-pull-through:$(COMMIT_SHA) .
