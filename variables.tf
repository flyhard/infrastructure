variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  default = "10.128.0.0/24"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.128.0.0/16"
}

variable "private_subnet_cidr" {
  description = "CIDR for private subnet"
  default     = "10.128.1.0/24"
}

/* Ubuntu 14.04 amis by region */
variable "amis" {
  description = "Base AMI to launch the instances with trusty ubuntu 14.04 LTS	amd64	hvm:ebs-ssd"
  default = {
    us-west-1 = "ami-06116566"
    us-east-1 = "ami-fce3c696"
    eu-west-1 = "ami-f95ef58a"
    eu-central-1 = "ami-87564feb"
  }
}
variable "access_key" {}
variable "secret_key" {}
variable "region" {
    default = "eu-west-1"
}
variable "availability_zone" {
    default = "eu-west-1a"
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

