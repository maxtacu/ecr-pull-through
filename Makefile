build:
	go build -o bin/mutation-webhook cmd/*.go

run:
	go run cmd/

kind-create:
	kind create cluster --config kind.yaml
