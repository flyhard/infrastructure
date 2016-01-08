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
  image = "debian-7-0-x64"
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
      "apt-get install -y docker",
      "docker run -d -P ${var.consul_image} -atlas-join -atlas \"flyhard/abich\" -atlas-token \"${var.atlas_token}\" -bootstrap"
    ]
  }
  connection {
    user = "root"
    type = "ssh"
    private_key = "${var.private_key}"
    timeout = "2m"
  }
}

# Create a new domain record
resource "digitalocean_domain" "default" {
name = "abich.com"
ip_address = "173.254.28.90"
}
# Create a new domain record
resource "digitalocean_domain" "www" {
name = "www.abich.com"
ip_address = "173.254.28.90"
}
# Create a new domain record
resource "digitalocean_domain" "mail" {
name = "mail.abich.com"
ip_address = "173.254.28.90"
}
# Create a new domain record
resource "digitalocean_domain" "test" {
  name = "test.abich.com"
  ip_address = "${digitalocean_droplet.example.ipv4_address}"
}

output "ip" {
value = "${digitalocean_droplet.example.ipv4_address}"
}
