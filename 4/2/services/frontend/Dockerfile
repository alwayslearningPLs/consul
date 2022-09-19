# golang:alpine with version 3.16 (last alpine version also)
FROM golang@sha256:c9a90742f5457fae80d8f9f1c9fc6acd6884c749dc6c5b11c22976973564dd4f as base

RUN apk add --no-cache --update git

WORKDIR /go/src/github.com/MrTimeout/consul/4/vm/services/frontend

COPY . .

RUN go mod download && go mod verify && \
  CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -ldflags="-w -s" -o /go/bin ./...

FROM alpine:3.16

RUN apk add --no-cache bash

ENV PORT=6060 \
  BACKEND_URL=http://localhost:6061

COPY --from=base /go/bin/frontend /frontend
COPY --from=base /go/src/github.com/MrTimeout/consul/4/vm/services/frontend/templates /templates

CMD ["/frontend"]
