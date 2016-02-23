//provider "consul" {
//  address = "${aws_route53_record.test.name}"
//}
//
//resource "consul_keys" "key" {
//  connection {
//    bastion_host = "${aws_route53_record.test.name}"
//    bastion_user = "ec2-user"
//    bastion_private_key = "${var.private_key}"
//  }
//  key {
//    name = "test"
//    path = "/test"
//    value = "lhlhl"
//  }
//}