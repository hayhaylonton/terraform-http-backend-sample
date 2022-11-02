terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
  backend "http" {
    address        = "http://localhost:8000/tfstate"
    lock_address   = "http://localhost:8000/tfstate/lock"
    unlock_address = "http://localhost:8000/tfstate/lock"
    username       = "admin@test.com"
    password       = "1234"
    workspaces {
      name = "my-app-prod"
    }
    organization = "company"
  }

}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:1.23.2"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = "tutorial"
  ports {
    internal = 80
    external = 8090
  }
}