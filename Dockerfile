FROM golang:1.22-alpine

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -o bin/mutation-webhook cmd/*.go

FROM gcr.io/distroless/base-debian10

COPY --from=0 /app/bin/mutation-webhook /

ENTRYPOINT [ "/mutation-webhook" ]
