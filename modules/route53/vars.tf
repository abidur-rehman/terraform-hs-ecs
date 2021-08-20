variable "environment" {
  default = ""
  description = "Name prefix for this environment."
}

variable "name_prefix_ts_api" {
    description = "Name prefix for the T2S API app."
}

variable "name_prefix_ts" {
    description = "Name prefix for the T2S app."
}

variable "alb_dns_name" {}

variable "alb_dns_zone_id" {}