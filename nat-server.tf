/* NAT/VPN server */
resource "aws_instance" "nat" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.nano"
  subnet_id = "${aws_subnet.public.id}"
  security_groups = ["${aws_security_group.default.id}", "${aws_security_group.nat.id}"]
  key_name = "${aws_key_pair.deployer.key_name}"
  source_dest_check = false
  tags = {
    Name = "nat"
  }
  connection {
    user = "root"
    type = "ssh"
    private_key = "${var.private_key}"
    timeout = "5m"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo iptables -t nat -A POSTROUTING -j MASQUERADE",
      "echo 1 | sudo tee /proc/sys/net/ipv4/conf/all/forwarding > /dev/null",
      /* Install docker */
      "curl -sSL https://get.docker.com/ | sudo sh",
      /* Initialize open vpn data container */
    ]
  }
}

output "nat.ip" {
  value = "${aws_instance.nat.public_ip}"
}
