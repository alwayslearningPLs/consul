build:
	go mod download
	go mod verify
	CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -ldflags="-w -s" -o /usr/local/bin ./...

install:
	@cp ./app.hcl /etc/consul.d/backend.hcl
	@cp ./app.service /etc/systemd/system/backend.service
	@cp ./app-sidecar-proxy.service /etc/systemd/system/backend-sidecar-proxy.service

all: build install
