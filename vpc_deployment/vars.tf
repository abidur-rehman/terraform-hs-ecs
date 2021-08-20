/* Terraform constraints */
terraform {
    required_version = ">= 0.12"
}

variable "name_prefix" {
    default = "hs"
    description = "Name prefix for the app."
}

variable "aws_region" {
    default = "eu-west-2"
    description = "Determine AWS region endpoint to access."
}

variable "cidr_vpc" {
    type = map(string)
    default = {
        test  = "10.85.131"
        dev = "10.85.132"
        stage = "10.85.133"
        prod = "10.85.134"
    }
}

locals {
    environment = lower(terraform.workspace)
    private_subnets  = [
        "${lookup(var.cidr_vpc, local.environment)}.0/27",
        "${lookup(var.cidr_vpc, local.environment)}.32/27",
    ]
    public_subnets  = [
        "${lookup(var.cidr_vpc, local.environment)}.64/27",
        "${lookup(var.cidr_vpc, local.environment)}.96/27"
    ]
    private_subnet_tags  = {
        Name = "${var.name_prefix}_${local.environment}_sub_pri"
    }
    public_subnet_tags  = {
        Name = "${var.name_prefix}_${local.environment}_sub_pub"
    }
    common_tags = [
        { key = "Name", value = "hs_${local.environment}_app_on_demand", propagate_at_launch = true },
        { key = "Environment", value = "Testing", propagate_at_launch = true },
        { key = "Role", value = "app_server", propagate_at_launch = true },
    ]
}

variable "ingress_ports" {
    type        = list(number)
    description = "list of ingress ports"
    default     = []
}

variable "db_instance_id" {}

variable "db_snapshot_id" {}

variable "username" {
    description = "Username of db"
}

variable "password" {
    description = "Password of db"
}

variable "name_prefix_ts_api" {
    description = "Name prefix for the T2S API app."
}

variable "name_prefix_ts" {
    description = "Name prefix for the T2S app."
}

variable "name_prefix_laparts_api" {
    description = "Name prefix for the Laparts API app."
}

variable "name_prefix_laparts" {
    description = "Name prefix for the Laparts app."
}

variable "ssl_certificate" {
    description = "Certificate endpoint"
}

variable "instance_type" {
    default = ""
    description = "EC2 instance type to use"
}

variable "ecs_image_id" {
    default = ""
}

variable "ec2_key_name" {}

variable "desired_capacity_on_demand" {}

variable "count_webapp" {}

variable "minimum_healthy_percent_webapp" {}

variable "ts_api_app_docker_image_name" {}

variable "ts_api_app_docker_image_tag" {}

variable "ts_app_docker_image_name" {}

variable "ts_app_docker_image_tag" {}

variable "laparts_api_app_docker_image_name" {}

variable "laparts_api_app_docker_image_tag" {}

variable "database_user" {}

variable "database_password" {}

variable "paypal_client_id" {}

variable "paypal_secret" {}

variable "txt_config_type" {}

variable "txt_config_project_id" {}

variable "txt_config_private_key_id" {}

variable "txt_config_private_key" {}

variable "txt_config_client_email" {}

variable "txt_config_client_id" {}

variable "txt_config_auth_uri" {}

variable "txt_config_token_uri" {}

variable "txt_config_auth_provider_x509_cert_url" {}

variable "txt_config_client_x509_cert_url" {}

variable "laparts_app_docker_image_name" {}

variable "laparts_app_docker_image_tag" {}

variable "razzle_host_username" {}

variable "razzle_host_password" {}

variable "razzle_google_api_key" {}

variable "razzle_google_client_id" {} 

variable "razzle_paypal_client_id" {}  