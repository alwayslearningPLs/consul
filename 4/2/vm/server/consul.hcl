datacenter        = "myhome"
data_dir          = "/opt/consul"
node_name         = "server"
log_level         = "INFO"

bootstrap_expect  = 1

server            = true
bind_addr         = "{{GetInterfaceIP \"eth1\"}}"
client_addr       = "0.0.0.0"

ports {
  grpc            = 8502
}

connect {
  enabled         = true
}

ui_config {
  enabled         = true
}

