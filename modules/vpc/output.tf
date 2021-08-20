output "vpc_id" {
    value = module.vpc.vpc_id
}

output "vpc_cdr" {
    value = module.vpc
}

/* Subnet IDs */
output "subnet_ids_pri" {
    value = module.vpc.private_subnets
}

output "subnet_ids_pub" {
    value = module.vpc.public_subnets
}
