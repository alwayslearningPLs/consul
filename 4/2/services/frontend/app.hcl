service {
  id    = "frontend"
  name  = "frontend"
  port  = 6060

  tags = [
    "frontend",
    "web",
    "users"
  ]

  check {
    args = [
      "curl",
      "http://localhost:6060/index"
    ],
    interval = "10s"
  }

  connect {
    sidecar_service {
      # It is not needed to specify the port of the sidecar proxy. Public port
      port = 21000

      proxy {
        # It configures which ports the sidecar proxy will expose and what services they'll route to.
        upstreams = [
          {
            destination_name = "backend"
# Local port to bind the proxy
            local_bind_port = 6050
          }
        ]
      }
    }
  }
}
