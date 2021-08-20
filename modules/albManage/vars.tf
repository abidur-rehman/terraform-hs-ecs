variable "environment" {
    default = ""
    description = "Name prefix for this environment."
}

variable "name_prefix" {
    default = ""
    description = "Name prefix for the app."
}

variable "name_prefix_with_hyphen" {
    default = ""
    description = "Name prefix with hyphen for the app."
}

variable "aws_region" {
    default = ""
    description = "Determine AWS region endpoint to access."
}

/* Consume common outputs */
variable "hrdd_manage_albs_sg_id" {}
variable "vpc_id" {}
variable "subnet_ids_pub" {}


variable "name_prefix_graf" {
    default = ""
    description = "Name prefix for the Grafana app."
}

variable "name_prefix_prom" {
    default = ""
    description = "Name prefix for the Prometheus app."
}

variable "ssl_certificate" {}


