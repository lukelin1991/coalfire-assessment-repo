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

output "mgmt_ec2_sg_id" {
  value = aws_security_group.mgmt_ec2_sg.id
}

output "app_asg_sg_id" {
  value = aws_security_group.app_asg_sg.id
}

output "mgmt_ec2_sg_ingress" {
  value = aws_security_group.mgmt_ec2_sg.ingress
}

output "app_asg_sg_ingress" {
  value = aws_security_group.app_asg_sg.ingress
}