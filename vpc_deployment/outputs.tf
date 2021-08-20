
# Outputs
#===============================================================================
output "ecs_instance_profile" {
  value = module.iam_roles.ecs_instance_profile
}

output "ecs_service_role" {
  value = module.iam_roles.ecs_service_role
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.subnet_ids_pri
}

output "public_subnets" {
  value = module.vpc.subnet_ids_pub
}

output "hs_albs_sg_id" {
  value = module.vpc_security_groups.hs_albs_sg_id
}

output "hs_instances_sg_id" {
  value = module.vpc_security_groups.hs_instances_sg_id
}

/*
output "rds_db_instance_source_snapshot" {
  value  = module.rds.db_instance_snapshot
}

output "rds_db_instance_id" {
  value  = module.rds.db_instance_address
}

output "rds_enpoint" {
  value  = module.rds.rds_endpoint
}
*/

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "alb_dns_zone_id" {
  value = module.alb.alb_dns_zone_id
}

output "alb_ts_api_app_alb_tg_arn" {
  value = module.alb.ts_api_app_alb_tg_arn
}

output "alb_ts_app_alb_tg_arn" {
  value = module.alb.ts_app_alb_tg_arn
}

/*
output "hrdd_api_app_url" {
  value = module.route53.route53_api_url
}
output "hrdd_lm_app_url" {
  value = module.route53.route53_lm_url
}
*/
#===============================================================================