variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-2"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "mgmt_subnet_cidrs" {
  description = "CIDRs for public subnets (Management)"
  type        = list(string)
  default     = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "app_subnet_cidrs" {
  description = "CIDRs for private Application subnets"
  type        = list(string)
  default     = ["10.1.3.0/24", "10.1.4.0/24"]
}

variable "backend_subnet_cidrs" {
  description = "CIDRs for private Backend subnets"
  type        = list(string)
  default     = ["10.1.5.0/24", "10.1.6.0/24"]
}

# AMI for EC2 instances (Ubuntu 24.04 LTS Free Tier)
variable "ami_id" {
  description = "AMI ID to use for EC2 instances"
  type        = string
  default     = "ami-0cfde0ea8edd312d4"
}