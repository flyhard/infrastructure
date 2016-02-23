resource "aws_route53_zone" "zone" {
  name = "${var.domain_name}"
}
resource "aws_route53_record" "default" {
  zone_id = "${aws_route53_zone.zone.zone_id}"
  name = "www.${var.domain_name}"
  ttl = "300"
  type = "A"
  records = [
    "${aws_instance.docker.public_ip}"]
}
resource "aws_route53_record" "web" {
  zone_id = "${aws_route53_zone.zone.zone_id}"
  name = "${var.domain_name}"
  ttl = "300"
  type = "A"
  records = [
    "${aws_instance.docker.public_ip}"]
}
resource "aws_route53_record" "mail" {
  zone_id = "${aws_route53_zone.zone.zone_id}"
  name = "mail.${var.domain_name}"
  ttl = "300"
  type = "A"
  records = [
    "${aws_instance.docker.public_ip}"]
}
resource "aws_route53_record" "mail_mx" {
  zone_id = "${aws_route53_zone.zone.zone_id}"
  name = "mail.${var.domain_name}"
  ttl = "300"
  type = "MX"
  records = [
    "10 ${aws_route53_record.mail.name}"]
}
