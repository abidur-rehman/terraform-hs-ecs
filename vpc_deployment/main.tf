/* Region settings for AWS provider */
provider "aws" {
  region = var.aws_region
}

# Modules
#===============================================================================
module "iam_roles" {
  source = "../modules/roles"
  environment = local.environment
  name_prefix = var.name_prefix
  aws_region = var.aws_region
}

module "vpc" {
  source = "../modules/vpc"
  environment = local.environment
  name_prefix = var.name_prefix
  aws_region = var.aws_region
  cidr_vpc = var.cidr_vpc
  private_subnets = local.private_subnets
  public_subnets = local.public_subnets
  private_subnet_tags = local.private_subnet_tags
  public_subnet_tags = local.public_subnet_tags
}

module "vpc_security_groups" {
  source = "../modules/security_groups"
  environment = local.environment
  name_prefix = var.name_prefix
  aws_region = var.aws_region
  vpc_id = module.vpc.vpc_id
}

/*
module "rds" {
  source = "../modules/rds_from_snapshot"
  environment = local.environment
  name_prefix = var.name_prefix
  cidr_vpc = var.cidr_vpc
  vpc_id = module.vpc.vpc_id
  ingress_ports = var.ingress_ports
  subnet_ids_pri = module.vpc.subnet_ids_pri
  db_snapshot_id = var.db_snapshot_id
  db_instance_id = var.db_instance_id
  username = var.username
  password = var.password
}
*/

module "alb" {
  source = "../modules/alb"
  environment = local.environment
  name_prefix = var.name_prefix
  vpc_id = module.vpc.vpc_id
  subnet_ids_pub = module.vpc.subnet_ids_pub
  hs_albs_sg_id = module.vpc_security_groups.hs_albs_sg_id
  name_prefix_ts_api = var.name_prefix_ts_api
  name_prefix_ts = var.name_prefix_ts
  name_prefix_laparts_api = var.name_prefix_laparts_api
  name_prefix_laparts = var.name_prefix_laparts
  ssl_certificate = var.ssl_certificate
}



module "ecs" {
  source = "../modules/ecs"
  environment = local.environment
  name_prefix = var.name_prefix
  count_webapp = var.count_webapp
  minimum_healthy_percent_webapp = var.minimum_healthy_percent_webapp
  ts_api_app_alb_tg_arn = module.alb.ts_api_app_alb_tg_arn
  ts_app_alb_tg_arn = module.alb.ts_app_alb_tg_arn
  //aparts_api_app_alb_tg_arn = module.alb.laparts_api_app_alb_tg_arn
  //laparts_app_alb_tg_arn = module.alb.laparts_app_alb_tg_arn
  ts_api_app_docker_image_name = var.ts_api_app_docker_image_name
  ts_api_app_docker_image_tag = local.environment
  ts_app_docker_image_name = var.ts_app_docker_image_name
  ts_app_docker_image_tag = local.environment
  razzle_env = local.environment
  /* laparts config removed
  laparts_api_app_docker_image_name = var.laparts_api_app_docker_image_name
  laparts_api_app_docker_image_tag = var.laparts_api_app_docker_image_tag
  database_url = module.rds.rds_endpoint
  database_user = var.database_user
  database_password = var.database_password
  laparts_app_docker_image_name = var.laparts_app_docker_image_name
  laparts_app_docker_image_tag = var.laparts_app_docker_image_tag
  paypal_client_id = var.paypal_client_id
  paypal_secret = var.paypal_secret
  razzle_host_username = var.razzle_host_username
  razzle_host_password = var.razzle_host_password
  razzle_google_api_key = var.razzle_google_api_key
  razzle_google_client_id = var.razzle_google_client_id
  razzle_paypal_client_id = var.razzle_paypal_client_id
  */
}


module "asg" {
  source = "../modules/asg"
  environment = local.environment
  name_prefix = var.name_prefix
  instance_type = var.instance_type
  ecs_instance_profile = module.iam_roles.ecs_instance_profile
  ec2_key_name = var.ec2_key_name
  hs_instances_sg_id = module.vpc_security_groups.hs_instances_sg_id
  desired_capacity_on_demand = var.desired_capacity_on_demand
  subnet_ids_pri = module.vpc.subnet_ids_pub
  compliance_tags = local.common_tags
  cluster_name = module.ecs.cluster_name
  txt_config_type = var.txt_config_type
  txt_config_project_id = var.txt_config_project_id
  txt_config_private_key_id = var.txt_config_private_key_id
  txt_config_private_key = var.txt_config_private_key
  txt_config_client_email = var.txt_config_client_email
  txt_config_client_id = var.txt_config_client_id
  txt_config_auth_uri = var.txt_config_auth_uri
  txt_config_token_uri = var.txt_config_token_uri
  txt_config_auth_provider_x509_cert_url = var.txt_config_auth_provider_x509_cert_url
  txt_config_client_x509_cert_url = var.txt_config_client_x509_cert_url
}

/*
module "route53" {
  source = "../modules/route53"
  environment = local.environment
  name_prefix_ts_api = var.name_prefix_ts_api
  name_prefix_ts = var.name_prefix_ts
  alb_dns_name = module.alb.alb_dns_name
  alb_dns_zone_id = module.alb.alb_dns_zone_id
}
*/

/* This is not needed as its achieved using aws_autoscaling_schedule
module "lambda" {
  source = "../modules/lambda"
  environment = local.environment
  name_prefix = var.name_prefix
}
*/