/* NAT/VPN server */
resource "aws_instance" "docker" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.nano"
  subnet_id = "${aws_subnet.public.id}"
  security_groups = ["${aws_security_group.default.id}", "${aws_security_group.basics.id}", "${aws_security_group.smtp.id}"]
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
  provisioner "file" {
    source = "modules"
    destination = "/tmp/modules"
  }
  provisioner "remote-exec" {
    inline = [
        "sudo yum install -y puppet3",
        "sudo mkdir -p /etc/facter/facts.d /etc/puppet",
        "sudo mv /tmp/modules /etc/puppet/",
        "echo cluster_name: '${aws_ecs_cluster.docker.name}' | sudo tee /etc/facter/facts.d/config.yaml",
        "echo sumo_id: '${var.sumo_id}' | sudo tee -a /etc/facter/facts.d/config.yaml",
        "echo sumo_key: '${var.sumo_key}' | sudo tee -a /etc/facter/facts.d/config.yaml",
        "sudo puppet apply --logdest syslog /tmp/puppet/dockerServer.pp",
        "sudo service sendmail stop",
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
