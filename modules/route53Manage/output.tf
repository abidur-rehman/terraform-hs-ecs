output "route53_prom_url" {
  value = "${aws_route53_record.hrdd_prom_record.name}.${data.aws_route53_zone.hrdd_route53_zone.name}"
}

output "route53_graf_url" {
  value = "${aws_route53_record.hrdd_graf_record.name}.${data.aws_route53_zone.hrdd_route53_zone.name}"
}
