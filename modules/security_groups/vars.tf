
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

variable "vpc_id" {
    default = ""
    description = "Id of the vpc."
}

variable "ingress_ports" {
    type        = list(number)
    description = "list of ingress ports"
    default     = [80, 443]
}