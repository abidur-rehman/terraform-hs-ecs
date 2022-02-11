variable "environment" {
  default = ""
  description = "Name prefix for this environment."
}

variable "name_prefix" {
  default = ""
  description = "Name prefix for the app."
}

variable "count_webapp" {
  default = ""
  description = "Number of minimum tasks to run"
}

variable "minimum_healthy_percent_webapp" {}

variable "ts_api_app_alb_tg_arn" {}

variable "ts_app_alb_tg_arn" {}

/* laparts config removed */
/*
variable "laparts_api_app_alb_tg_arn" {}

variable "laparts_app_alb_tg_arn" {}
*/

variable "ts_api_app_docker_image_name" {}

variable "ts_api_app_docker_image_tag" {}

variable "ts_app_docker_image_name" {}

variable "ts_app_docker_image_tag" {}

variable "razzle_env" {}

/* laparts config removed */
/*
variable "laparts_api_app_docker_image_name" {}

variable "laparts_api_app_docker_image_tag" {}

variable "database_url" {}

variable "database_user" {}

variable "database_password" {}

variable "paypal_client_id" {}

variable "paypal_secret" {}

variable "laparts_app_docker_image_name" {}

variable "laparts_app_docker_image_tag" {}

variable "razzle_host_username" {}

variable "razzle_host_password" {}

variable "razzle_google_api_key" {}

variable "razzle_google_client_id" {}

variable "razzle_paypal_client_id" {}
*/