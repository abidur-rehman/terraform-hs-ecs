/**
  * DNS name from ALB
  * In production, you can add this DNS Name to Route 53 (your domain)
  */
output "alb_manage_dns_name" {
    value = aws_alb.hrdd_manage_alb.dns_name
}

output "alb_manage_dns_zone_id" {
    value = aws_alb.hrdd_manage_alb.zone_id
}

output "prom_app_alb_tg_arn" {
    value = aws_alb_target_group.prometheus_app_alb_tg.arn
}

output "graf_app_alb_tg_arn" {
    value = aws_alb_target_group.grafana_app_alb_tg.arn
}
