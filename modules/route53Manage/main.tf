data "aws_route53_zone" "hrdd_route53_zone" {
  name         = "people-dev-development.dwpcloud.uk."
  private_zone = false
}

resource "aws_route53_record" "hrdd_prom_record" {
  zone_id = data.aws_route53_zone.hrdd_route53_zone.zone_id
  name    = "${var.name_prefix_prom}-${var.environment}"
  type    = "A"

  alias {
    name                   = var.alb_manage_dns_name
    zone_id                = var.alb_manage_dns_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "hrdd_graf_record" {
  zone_id = data.aws_route53_zone.hrdd_route53_zone.zone_id
  name    = "${var.name_prefix_graf}-${var.environment}"
  type    = "A"

  alias {
    name                   = var.alb_manage_dns_name
    zone_id                = var.alb_manage_dns_zone_id
    evaluate_target_health = true
  }
}


