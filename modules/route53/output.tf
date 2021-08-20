output "route53_api_url" {
  value = "${aws_route53_record.hrdd_api_record.name}.${data.aws_route53_zone.hrdd_route53_zone.name}"
}

output "route53_lm_url" {
  value = "${aws_route53_record.hrdd_lm_record.name}.${data.aws_route53_zone.hrdd_route53_zone.name}"
}

output "route53_cad_url" {
  value = "${aws_route53_record.hrdd_cad_record.name}.${data.aws_route53_zone.hrdd_route53_zone.name}"
}