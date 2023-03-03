## Fetch AZs in the current region
data "aws_availability_zones" "available_az" {
}

module "vpc" {
  source               = "registry.terraform.io/terraform-aws-modules/vpc/aws"
  name                 = var.deployment_app_name
  cidr                 = var.vpc_cidr_block
  azs                  = [for idx, z in data.aws_availability_zones.available_az.names : z if idx <= var.az_count]
  private_subnets      = [cidrsubnet(var.vpc_cidr_block, 8, 0), cidrsubnet(var.vpc_cidr_block, 8, 1)]
  public_subnets       = [cidrsubnet(var.vpc_cidr_block, 8, 2), cidrsubnet(var.vpc_cidr_block, 8, 3)]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
}
