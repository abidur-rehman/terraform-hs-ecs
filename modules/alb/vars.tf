variable "environment" {
    default = ""
    description = "Name prefix for this environment."
}

variable "name_prefix" {
    default = ""
    description = "Name prefix for the app."
}

variable "aws_region" {
    default = ""
    description = "Determine AWS region endpoint to access."
}

/* Consume common outputs */
variable "hs_albs_sg_id" {}
variable "vpc_id" {}
variable "subnet_ids_pub" {}

variable "name_prefix_ts_api" {
    default = ""
    description = "Name prefix for the TSP API app."
}

variable "name_prefix_ts" {
    default = ""
    description = "Name prefix for the TSP app."
}

variable "name_prefix_laparts_api" {
    default = ""
    description = "Name prefix for the Laparts API app."
}


variable "name_prefix_laparts" {
    default = ""
    description = "Name prefix for the Laparts app."
}

variable "ssl_certificate" {}


