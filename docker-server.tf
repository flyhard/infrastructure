/* NAT/VPN server */
resource "aws_instance" "docker" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.nano"
  subnet_id = "${aws_subnet.public.id}"
  security_groups = ["${aws_security_group.default.id}", "${aws_security_group.nat.id}"]
  key_name = "${aws_key_pair.deployer.key_name}"
  source_dest_check = false
  iam_instance_profile = "${aws_iam_instance_profile.default.name}"
  availability_zone = "${var.availability_zone}"

  tags = {
    Name = "docker"
  }
  connection {
    user = "ec2-user"
    type = "ssh"
    private_key = "${var.private_key}"
    timeout = "5m"
  }
  provisioner "file" {
    source = "cloud-config"
    destination = "/tmp/puppet/"
  }
  provisioner "remote-exec" {
    inline = [
        "sudo yum install -y puppet3",
        "sudo FACTER_CLUSTER_NAME=${aws_ecs_cluster.docker.name} puppet apply /tmp/puppet/dockerServer.pp",
    ]
  }
}

resource "aws_eip" "docker" {
  instance = "${aws_instance.docker.id}"
  vpc = true
}

output "docker.ip" {
  value = "${aws_instance.docker.public_ip}"
}
