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

variable "graf_app_alb_tg_arn" {}

variable "prom_app_alb_tg_arn" {}

variable "prom_docker_image_name" {}

variable "prom_docker_image_tag" {}

variable "graf_docker_image_name" {}

variable "graf_docker_image_tag" {}



