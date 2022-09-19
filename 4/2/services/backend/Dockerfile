# golang:alpine with version 3.16 (last alpine version also)
FROM golang@sha256:c9a90742f5457fae80d8f9f1c9fc6acd6884c749dc6c5b11c22976973564dd4f as base

RUN apk add --no-cache --update ca-certificates git

WORKDIR /go/src/github.com/MrTimeout/consul/4/vm/services/backend

COPY . .

RUN go mod download && go mod verify && \
  CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -ldflags="-w -s" -o /go/bin ./...

FROM scratch

COPY --from=base /go/bin/backend /backend

CMD ["/backend"]
