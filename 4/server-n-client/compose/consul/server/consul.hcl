datacenter          = "myhome"
node_name           = "server"
data_dir            = "/opt/consul"
bootstrap           = true
enable_script_checks= true

domain              = "consul"
log_level           = "INFO"
server              = true
client_addr         = "0.0.0.0"
bind_addr           = "{{ GetAllInterfaces | include \"name\" \"eth\" | attr \"address\" }}"

ports {
  grpc              = 8502
  dns               = 8600
}

connect {
  enabled           = true
}

ui_config {
  enabled           = true
}

dns_config {
  allow_stale       = true
  max_stale         = "87600h"
  enable_truncate   = true
  only_passing      = true
}

