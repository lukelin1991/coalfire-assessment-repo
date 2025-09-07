#security group for EC2 instance - Testing
resource "aws_security_group" "mgmt_ec2_sg" {
  name        = "mgmt-ec2-sg"
  description = "SecGroup Allow SSH from my IP"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SecGroup Allow SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip] # defined in variables.tf
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mgmt-ec2-sg"
  }
}

# Management EC2
module "management_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.1.1"

  for_each = {
    az1 = module.vpc.public_subnets[0]  # us-east-2a pub subnet
    az2 = module.vpc.public_subnets[1]  # us-east-2b pub subnet
  }
  name          = "mgmt-ec2-${each.key}"
  instance_type = "t2.micro"
  ami           = var.ami_id
  subnet_id     = each.value
  
  #for SG implementation later*** too many errors for now.
  vpc_security_group_ids = [aws_security_group.mgmt_ec2_sg.id]

  tags = {
    Role = "mgmt-ec2"
  }
}

# Security Group for ASG
resource "aws_security_group" "app_asg_sg" {
  name        = "app-asg-sg"
  description = "ASG instances security group"
  vpc_id      = module.vpc.vpc_id

  # SSH only from mgmt EC2
  ingress {
    description              = "SSH from mgmt EC2"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    security_groups          = [aws_security_group.mgmt_ec2_sg.id]
  }

  # HTTP only from ALB (we’ll wire ALB later)
  ingress {
    description              = "HTTP from ALB"
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
    security_groups          = [] # attach ALB SG later
  }

  # Allow all outbound (default)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-asg-sg"
  }
}

#AutoScaling group for App EC2 instances
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "9.0.1"

  name             = "app-asg"
  min_size         = 2
  max_size         = 6
  desired_capacity = 2
  vpc_zone_identifier = module.vpc.private_subnets

  create_launch_template = true
  instance_type          = "t2.micro"
  image_id               = var.ami_id

  security_groups = [aws_security_group.app_asg_sg.id]
  
  # user_data = file("${path.module}/scripts/install_apache.sh") #This script was suppose to install apache server, but throwing errors currently. 

  #uses traffic_source_attachments to attach to ALB target group - CURRENTLY BROKEN.
  # traffic_source_attachments = {
  #   alb_attachment = {
  #     traffic_source_identifier = module.alb.target_groups["app_tg"].arn
  #     traffic_source_type       = "elbv2"
  #   }
  # }

  tags = {
    Role = "app-asg"
  }
}
