service {
  name = "backend"
  id   = "backend"
  port = 6061

  tags = [
    "backend",
    "server"
  ]

  connect {
    sidecar_service {
      port = 22000

# This configuration is not really needed, because we don't need to route the backend service to the frontend service that specific.
      proxy {
# It configures which ports the sidecar proxy will expose and what services they'll route to.
        upstreams = [
          {
            destination_name = "frontend"
# Local port to bind the proxy
            local_bind_port = 6051
          }
        ]
      }
    }
  }
}
