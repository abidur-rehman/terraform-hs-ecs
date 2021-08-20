/**
  * DNS name from ALB
  * In production, you can add this DNS Name to Route 53 (your domain)
  */
output "alb_dns_name" {
    value = aws_alb.hs_alb.dns_name
}

output "alb_dns_zone_id" {
    value = aws_alb.hs_alb.zone_id
}

output "ts_api_app_alb_tg_arn" {
    value = aws_alb_target_group.ts_api_app_alb_tg.arn
}

output "ts_app_alb_tg_arn" {
    value = aws_alb_target_group.ts_app_alb_tg.arn
}

output "laparts_api_app_alb_tg_arn" {
    value = aws_alb_target_group.laparts_api_app_alb_tg.arn
}


output "laparts_app_alb_tg_arn" {
    value = aws_alb_target_group.laparts_app_alb_tg.arn
}
