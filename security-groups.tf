/* Default security group */
resource "aws_security_group" "default" {
  name = "default-access"
  description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    self = true
  }

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    self = true
  }

  tags {
    Name = "default-access"
  }
}

/* Security group for the nat server */
resource "aws_security_group" "basics" {
  name = "main-server-basic-access"
  description = "Security group for nat instances that allows SSH and VPN traffic from internet. Also allows outbound HTTP[S]"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 25
    to_port = 25
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags {
    Name = "main-server-basic-access"
  }
}

/* Security group for the web */
resource "aws_security_group" "web" {
  name = "web-server-access"
  description = "Security group for web that allows web traffic from internet"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags {
    Name = "web-server-access"
  }
}

resource "aws_security_group" "smtp" {
  name = "smtp-group"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 25
    to_port = 25
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 25
    to_port = 25
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags {
    Name = "smtp-group"
  }
}