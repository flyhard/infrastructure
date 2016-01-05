provider "digitalocean" {
    token = "${var.do_token}"
}

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "${var.region}"
}

resource "digitalocean_droplet" "example" {
    image = "ubuntu-14-04-x64"
    name = "web-1"
    region = "${var.do_region}"
    size = "512mb"
    ssh_keys = [1582240]
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
