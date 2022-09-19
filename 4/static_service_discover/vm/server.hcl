connect {
  enabled = true
}

ports {
  grpc = 8502
}

server = true

bootstrap_expect = 1

ui_config {
  enabled = true
}

client_addr = "0.0.0.0"

# Help: https://pkg.go.dev/github.com/hashicorp/go-sockaddr/template
bind_addr = "{{GetInterfaceIP \"eth1\"}}"

