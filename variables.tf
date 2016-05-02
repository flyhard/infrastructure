variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  default = "10.128.0.0/24"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default = "10.128.0.0/16"
}

variable "private_subnet_cidr" {
  description = "CIDR for private subnet"
  default = "10.128.1.0/24"
}

/* Ubuntu 14.04 amis by region */
variable "amis" {
  description = "Base AMI to launch the instances with trusty ubuntu 14.04 LTS	amd64	hvm:ebs-ssd"
  default = {
    ap-northeast-1="ami-d7d4c5b9"
    ap-northeast-2="ami-9a03caf4"
    ap-southeast-1="ami-73974210"
    ap-southeast-2="ami-09daf96a"
    eu-central-1="ami-ccc021a3"
    eu-west-1="ami-e079f893"
    sa-east-1="ami-d3ae21bf"
    us-east-1="ami-c8bda8a2"
    us-west-1="ami-45374b25"
    us-west-2="ami-98e114f8"
  }
}
variable "aws_account_id" {}
variable "access_key" {
}
variable "key_path" {
  default = "provision_key"
}
variable "secret_key" {
}
variable "region" {
  default = "eu-west-1"
}
variable "availability_zone" {
  default = "eu-west-1a"
}

variable "public_key" {
}

variable "atlas_token" {
}

variable "atlasName" {
  default = "flyhard/abich"
}

variable "consul_image" {
  default = "flyhard/consul"
}
variable "domain_name" {}

variable "sumo_id" {}

variable "sumo_key" {}