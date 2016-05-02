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
    user = "admin"
    type = "ssh"
    private_key = "${file(var.key_path)}"
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
  provisioner "file" {
    source = "compose"
    destination = "/tmp/compose"
  }
  provisioner "file" {
    source = "scripts"
    destination = "/tmp/scripts"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/scripts/*",
      "/tmp/scripts/provision.sh ${var.sumo_id} ${var.sumo_key}"
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
