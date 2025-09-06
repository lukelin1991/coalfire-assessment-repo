# will need a security group for EC2 instance later

# Management EC2
module "management_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.1.1"

  name          = "management-ec2"
  instance_type = "t2.micro"
  ami           = var.ami_id
  subnet_id     = element(module.vpc.public_subnets, 0)
  
  #for SG implementation later*** too many errors for now.
  vpc_security_group_ids = []
  tags = {
    Role = "mgmt-ec2"
  }
}

# Security Group for ASG
resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "ASG instances security group"
  vpc_id      = module.vpc.vpc_id

  # No ingress for now

  # Allow all outbound (default)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-sg"
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

  security_groups = [aws_security_group.app_sg.id]

  tags = {
    Role = "app-asg"
  }
}
