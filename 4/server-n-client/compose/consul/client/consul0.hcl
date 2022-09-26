datacenter  = "myhome"
node_name   = "client0"
data_dir    = "/opt/consul"
log_level   = "INFO"

server      = false
client_addr = "0.0.0.0"
bind_addr   = "{{ GetAllInterfaces | include \"name\" \"eth\" | attr \"address\" }}"

retry_join  = [
  "server"
]

