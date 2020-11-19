job "random-logger-example" {
  datacenters = ["dc1"]
  type = "service"

  group "random" {
    count = 1

    task "random" {
      driver = "docker"
      config {
        image = "chentex/random-logger"
        port_map {
          http = 8088
        }
      }
      resources {
        network {
          port "http" {}
        }
      }
      service {
        tags = [
          "nomad_follower",
          "test"
        ]
        name = "random"
        port = "http"
      }
    }
  }
}
