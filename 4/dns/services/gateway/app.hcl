service {
  name    = "ingress-gateway"
  kind    = "ingress-gateway"
  port    = 20000
  checks  = [
    {
      name      = "ingress gateway check"
      tcp       = "localhost:20000"
      interval  = "30s"
    }
  ]
}
