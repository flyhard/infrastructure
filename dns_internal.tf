//resource "aws_route53_zone" "internal" {
//  name = "internal.abich.com"
//  vpc_id = "${aws_vpc.default.id}"
//}
//
//resource "aws_route53_record" "dev-ns" {
//  zone_id = "${aws_route53_zone.internal.zone_id}"
//  name = "internal.abich.com"
//  type = "NS"
//  ttl = "30"
//  records = [
//    "${aws_route53_zone.internal.name_servers.0}",
//    "${aws_route53_zone.internal.name_servers.1}",
//    "${aws_route53_zone.internal.name_servers.2}",
//    "${aws_route53_zone.internal.name_servers.3}"
//  ]
//}

//resource "aws_route53_record" "consul" {
//  zone_id = "${aws_route53_zone.internal.zone_id}"
//  name = "consul"
//  type = "CNAME"
//  ttl="30"
//  records = [
//    "${aws_ecs_service.consul.}"
//  ]
//}