#not fully working yet, but close. Need to figure out how to link ALB to ASG.
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.17.0"

  name    = "app-alb"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets  # ALB in public subnets

  # Security Group rules
  security_group_ingress_rules = {
    http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow HTTP traffic from the internet"
    }
  }

  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = var.vpc_cidr  # Allow outbound to VPC
    }
  }

  # Target Groups
  target_groups = {
    app_tg = {
      name = "app-asg-tg"
      port        = 80
      protocol    = "HTTP"
      target_type = "instance"

    }
  }

  # Listeners
  listeners = {
    http_listener = {
      port     = 80
      protocol = "HTTP"
      forward  = {
        target_group_key = "app_tg"
      }
    }
  }
}