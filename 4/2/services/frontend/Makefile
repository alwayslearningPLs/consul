build:
	go mod download
	go mod verify
	CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -ldflags="-w -s" -o /usr/local/bin ./...

install:
	@cp ./app.hcl /etc/consul.d/frontend.hcl
	@cp -r ./templates /usr/local/bin/templates/
	@cp ./app.service /etc/systemd/system/frontend.service
	@cp ./app-sidecar-proxy.service /etc/systemd/system/frontend-sidecar-proxy.service

all: build install
