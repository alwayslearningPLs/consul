service {
  # If we don't specify the id, then we take the name by default. It's not possible to have more than one service with the same id in a node.
  id = "myserver"
  name = "myserver"
  port = 5000

  tags = [ "home", "ping" ]
  # by default this value is set to the agent IP address
  address = "myserver"

  meta = {
    firstkey = "firstvalue"
    secondkey = "secondvalue"
  }

  # https://developer.hashicorp.com/consul/docs/discovery/checks#http-interval
  checks = [
    {
      id = "ping-service"
      name = "HTTP API on port 5000"
      http = "http://myserver:5000/ping"

      # By default the method that we use is GET
      method = "GET"
      header = {
        Accept = ["text/plain"]
      }
      # body

      # By default, false
      disable_redirects = true

      interval = "15s"
      # By default, 10s
      timeout = "5s"
    }
  ]
}
