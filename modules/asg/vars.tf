variable "environment" {
  default = ""
  description = "Name prefix for this environment."
}

variable "name_prefix" {
  default = ""
  description = "Name prefix for the app."
}

variable "instance_type" {
  default = ""
  description = "EC2 instance type to use"
}

variable "ecs_instance_profile" {}

variable "ec2_key_name" {}

variable "desired_capacity_on_demand" {}

variable "subnet_ids_pri" {}

variable "hs_instances_sg_id" {}

variable "compliance_tags" {}

variable "cluster_name" {}

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