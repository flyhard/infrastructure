provider "digitalocean" {
  token = "${var.do_token}"
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "digitalocean_ssh_key" "defaultKey" {
  name = "deployment key"
  public_key = "${var.public_key}"
}

resource "digitalocean_droplet" "example" {
  image = "debian-8-x64"
  name = "web-1"
  region = "${var.do_region}"
  size = "512mb"
  ssh_keys = [
    1582240,
    "${digitalocean_ssh_key.defaultKey.fingerprint}"
  ]
  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get install -y curl",
      "curl -sSL https://get.docker.com/ | sh",
      "docker run -d -P --name=consul ${var.consul_image} -atlas-join -atlas \"flyhard/abich\" -atlas-token \"${var.atlas_token}\" -bootstrap",
      "docker run -d --link consul:consul --name=registrator --volume=/var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest consul://consul:8500"
    ]
  }
  connection {
    user = "root"
    type = "ssh"
    private_key = "${var.private_key}"
    timeout = "2m"
  }
}

# Configure the Docker provider
provider "docker" {
  host = "tcp://127.0.0.1:1234/"
}

# Create a new domain record
resource "digitalocean_domain" "default" {
  name = "abich.com"
  ip_address = "173.254.28.90"
}
# Create a new domain record
resource "digitalocean_record" "www" {
  domain = "${digitalocean_domain.default.name}"
  type = "A"
  name = "www"
  value = "173.254.28.90"
}
# Create a new domain record
resource "digitalocean_record" "mail" {
  domain = "${digitalocean_domain.default.name}"
  type = "A"
  name = "mail"
  value = "173.254.28.90"
}
# Create a new domain record
resource "digitalocean_record" "test" {
  domain = "${digitalocean_domain.default.name}"
  type = "A"
  name = "test"
  value = "${digitalocean_droplet.example.ipv4_address}"
}

output "ip" {
value = "${digitalocean_droplet.example.ipv4_address}"
}
