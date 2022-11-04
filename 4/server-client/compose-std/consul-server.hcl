datacenter = "cloudia"
node_name = "bruny"
data_dir = "/consul/data"
bootstrap = true
enable_local_script_checks = true

domain = "consul"
log_level = "INFO"

server = true
client_addr = "0.0.0.0"
bind_addr = "{{ GetAllInterfaces | include \"name\" \"eth\" | attr \"address\" }}"

ports {
  grpc = 8502
  dns  = 8600
}

connect {
  enabled = true
}

ui_config {
  enabled = true
}

dns_config {
  allow_stale = true
  max_stale = "87600h"
  enable_truncate = true
  only_passing = true
}
