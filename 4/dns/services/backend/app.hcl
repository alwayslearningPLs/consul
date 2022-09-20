service {
  name = "backend"
  id   = "backend"
  port = 6060

  tags = [
    "primary",
    "server",
    "web"
  ]

  connect {
    sidecar_service {
      port = 22000
    }
  }
}
