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
    us-east-1 = "ami-cb2305a1"
    us-west-1 = "ami-bdafdbdd"
    us-west-2 = "ami-ec75908c"
    eu-west-1 = "ami-13f84d60"
    eu-central-1 = "ami-c3253caf"
    ap-northeast-1 = "ami-e9724c87"
    ap-southeast-1 = "ami-5f31fd3c"
    ap-southeast-2 = "ami-83af8ae0"
  }
}
variable "aws_account_id" {}
variable "access_key" {
}
variable "secret_key" {
}
variable "region" {
  default = "eu-west-1"
}
variable "availability_zone" {
  default = "eu-west-1a"
}
variable "do_token" {
}
variable "do_region" {
  default = "lon1"
}

variable "private_key" {
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

