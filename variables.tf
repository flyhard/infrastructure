variable "access_key" {}
variable "secret_key" {}
variable "region" {
    default = "eu-central-1"
}
variable "do_token" {}
variable "do_region" {
    default = "lon1"
}

variable "private_key" {}
variable "public_key" {}

variable "atlas_token" {}

variable "consul_image" {
    default = "flyhard/consul"
}

