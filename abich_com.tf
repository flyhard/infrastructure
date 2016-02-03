provider "digitalocean" {
  token = "${var.do_token}"
}

resource "aws_route53_zone" "abich_com" {
  name = "abich.com"
}
resource "aws_route53_record" "default" {
  zone_id = "${aws_route53_zone.abich_com.zone_id}"
  name = "www.abich.com"
  ttl = "300"
  type = "A"
  records = [
    "173.254.28.90"]
}
resource "aws_route53_record" "default" {
  zone_id = "${aws_route53_zone.abich_com.zone_id}"
  name = "abich.com"
  ttl = "300"
  type = "A"
  records = [
    "173.254.28.90"]
}
resource "aws_route53_record" "mail" {
  zone_id = "${aws_route53_zone.abich_com.zone_id}"
  name = "mail.abich.com"
  ttl = "300"
  type = "A"
  records = [
    "173.254.28.90"]
}
resource "aws_route53_record" "mail_mx" {
  zone_id = "${aws_route53_zone.abich_com.zone_id}"
  name = "mail.abich.com"
  ttl = "300"
  type = "MX"
  records = [
    "10 mail.abich.com"]
}
resource "aws_route53_record" "test" {
  zone_id = "${aws_route53_zone.abich_com.zone_id}"
  name = "test.abich.com"
  ttl = "60"
  type = "A"
  records = [
    "${aws_instance.docker.public_ip}"]
}
