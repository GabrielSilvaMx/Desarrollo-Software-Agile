terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.23.0"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine" # Para Windows
  # host = "unix:///var/run/docker.sock" # Para Linux
}

# Pulls the image
resource "docker_image" "microservice" {
  name = "microservice"
  build {
    path = "microservice/."
    tag  = [
      "microservice:latest"
      ]
  }
}

# Create a container
resource "docker_container" "microservice" {
  image = docker_image.microservice.image_id
  name  = "microservice-demo"
  ports {
    internal = 5000
    external = 5000
  }
  depends_on = [
    docker_image.microservice
  ]
}
