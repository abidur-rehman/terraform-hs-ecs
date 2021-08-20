variable "environment" {
  default = ""
  description = "Name prefix for this environment."
}

variable "name_prefix" {
  default = ""
  description = "Name prefix for the app."
}

variable "vpc_id" {}

variable "subnet_ids_pri" {
  type        = list(string)
  description = "list of subnet ids"
  default     = []
}

variable "db_instance_id" {}

variable "db_snapshot_id" {}

variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = []
}

variable "username" {
  description = "Username of db"
}

variable "password" {
  description = "Password of db"
}

variable "cidr_vpc" {
  type = map(string)
  default = {
    test    = ""
  }
}