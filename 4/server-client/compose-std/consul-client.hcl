datacenter  = "cloudia"
node_name   = "caiman"
data_dir    = "/consul/data"
log_level   = "INFO"

server      = false
client_addr = "0.0.0.0"
bind_addr   = "{{ GetAllInterfaces | include \"name\" \"eth\" | attr \"address\" }}"

retry_join  = [
  "server"
]
