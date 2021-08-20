data "aws_route53_zone" "hs_route53_zone" {
  name         = "people-dev-development.dwpcloud.uk."
  private_zone = false
}

resource "aws_route53_record" "hs_ts_api_record" {
  zone_id = data.aws_route53_zone.hs_route53_zone.zone_id
  name    = "${var.name_prefix_ts_api}-${var.environment}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_dns_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "hs_ts_record" {
  zone_id = data.aws_route53_zone.hs_route53_zone.zone_id
  name    = "${var.name_prefix_ts}-${var.environment}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_dns_zone_id
    evaluate_target_health = true
  }
}