.PHONY: help build run kind-create docker-build
COMMIT_SHA=$(shell git rev-parse --short HEAD)

## help: print this help message
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

# build: build the mutation-webhook binary
build:
	go build -o bin/mutation-webhook cmd/*.go

# run: run the mutation-webhook binary
run:
	go run cmd/

# kind-create: create a kind cluster using the kind.yaml configuration
kind-create:
	kind create cluster --config kind.yaml

# docker-build: build the docker image
docker-build:
	docker build -t ghcr.io/maxtacu/ecr-pull-through:$(COMMIT_SHA) .
