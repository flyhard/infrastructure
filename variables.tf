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
    us-east-1 = "ami-67a3a90d"
    us-west-1 = "ami-b7d5a8d7"
    us-west-2 = "ami-c7a451a7"
    eu-west-1 = "ami-9c9819ef"
    eu-central-1 = "ami-9aeb0af5"
    ap-northeast-1 = "ami-7e4a5b10"
    ap-southeast-1 = "ami-be63a9dd"
    ap-southeast-2 = "ami-b8cbe8db"
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