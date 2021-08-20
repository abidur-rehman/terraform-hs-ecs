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

variable "cidr_vpc" {
    type = map(string)
    default = {
        test    = ""
    }
}

variable "private_subnets" {}

variable "public_subnets" {}

variable "private_subnet_tags" {}

variable "public_subnet_tags" {}

locals {
    availability_zones = data.aws_availability_zones.available.names
}



