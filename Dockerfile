ARG BUILDPLATFORM

FROM --platform=${BUILDPLATFORM} golang:1.22-alpine

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOARCH=${TARGETARCH} GOOS=${TARGETOS} go build -o bin/mutation-webhook cmd/*.go

FROM --platform=${TARGETPLATFORM} gcr.io/distroless/base-debian10

COPY --from=0 /app/bin/mutation-webhook /

ENTRYPOINT [ "/mutation-webhook" ]
