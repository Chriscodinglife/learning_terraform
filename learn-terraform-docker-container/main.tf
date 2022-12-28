# Prepare the proper provider to communicate with the docker api
terraform {
    required_providers {
       docker = {
        source = "kreuzwerker/docker"
        version = ">= 2.13.0"
       }
    }
}

# Using the docker provider, point to the host
provider "docker" {
    host = "npipe:////.//pipe//docker_engine"
}

# Create a docker image resource called nginx
resource "docker_image" "nginx" {
    name = "nginx:latest"
    keep_locally = false
}

# Create a docker container called nginx and use the docker image created earlier
resource "docker_container" "nginx" {
    image = docker_image.nginx.name
    name = var.container_name
    ports {
        internal = 80
        external = 8080
    }
}