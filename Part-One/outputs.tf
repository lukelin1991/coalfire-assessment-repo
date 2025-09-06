output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

#Test to show private has NO internet access, public has YES for internet access
output "all_subnets_info" {
  value = [
    for s in concat(module.vpc.public_subnets, module.vpc.private_subnets) :
    {
      subnet_id = s
      type      = contains(module.vpc.public_subnets, s) ? "public" : "private"
      internet_access = contains(module.vpc.public_subnets, s) ? "YES" : "NO"
    }
  ]
}