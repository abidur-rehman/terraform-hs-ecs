module "vpc" {
    source            = "terraform-aws-modules/vpc/aws"
    version           = "~>2.23"
    name              = "${var.name_prefix}_${var.environment}_vpc"
    cidr              = "${lookup(var.cidr_vpc, var.environment)}.0/25"
    private_subnets   = var.private_subnets
    public_subnets    = var.public_subnets

    azs               = local.availability_zones

    enable_nat_gateway = true
    single_nat_gateway = true
    one_nat_gateway_per_az = false
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "${var.name_prefix}_${var.environment}_vpc"
    }

    private_subnet_tags = var.private_subnet_tags
    public_subnet_tags = var.public_subnet_tags
}

