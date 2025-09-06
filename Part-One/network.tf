module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = "poc-vpc"
  cidr = var.vpc_cidr

  azs             = ["us-east-2a", "us-east-2b"]
  public_subnets   = var.mgmt_subnet_cidrs   # Management
  private_subnets = concat(var.app_subnet_cidrs, var.backend_subnet_cidrs)   # Application + Backend

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Project = "poc"
  }
}