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
        "sudo yum install -y puppet",
        "sudo puppet apply /tmp/puppet/dockerServer.pp",
        "echo ECS_CLUSTER=${aws_ecs_cluster.docker.name} | sudo tee /etc/ecs/ecs.config",
        "sudo docker rm ecs-agent",
        "sudo rm -rf /var/lib/ecs/*",
        "sudo /usr/libexec/amazon-ecs-init start || cat /var/log/ecs/*",
        "sudo usermod -a -G docker ec2-user"
    ]
  }
}

output "docker.ip" {
  value = "${aws_instance.docker.public_ip}"
}
