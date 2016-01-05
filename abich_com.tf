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

output "ip" {
    value = "${digitalocean_droplet.example.ipv4_address}"
}
