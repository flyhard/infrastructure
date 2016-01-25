/* NAT/VPN server */
resource "aws_instance" "nat" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.nano"
  subnet_id = "${aws_subnet.public.id}"
  security_groups = ["${aws_security_group.default.id}", "${aws_security_group.nat.id}"]
  key_name = "${aws_key_pair.deployer.key_name}"
  source_dest_check = false
  iam_instance_profile = "${aws_iam_instance_profile.default.name}"

  tags = {
    Name = "nat"
  }
  connection {
    user = "ec2-user"
    type = "ssh"
    private_key = "${var.private_key}"
    timeout = "5m"
  }
  provisioner "remote-exec" {
    inline = [
        "echo ECS_CLUSTER=${aws_ecs_cluster.docker.name} | sudo tee /etc/ecs/ecs.config",
        "sudo docker rm ecs-agent",
        "sudo rm -rf /var/lib/ecs/*",
        "sudo /usr/libexec/amazon-ecs-init start"
    ]
  }
}

output "nat.ip" {
  value = "${aws_instance.nat.public_ip}"
}
