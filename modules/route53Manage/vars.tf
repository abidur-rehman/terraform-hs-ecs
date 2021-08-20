variable "environment" {
  default = ""
  description = "Name prefix for this environment."
}

variable "name_prefix_prom" {
  default = ""
  description = "Name prefix for the Prometheus app."
}

variable "name_prefix_graf" {
  default = ""
  description = "Name prefix for the Grafana app."
}

variable "alb_manage_dns_name" {}

variable "alb_manage_dns_zone_id" {}