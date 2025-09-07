### coalfire-assessment-repo
This is my attempt at Coalfire's Terraform Technical Assessment challenge, with AWS. 

Deliverables
1. Public GitHub repository containing:
o All Terraform configurations
o Architecture diagram
o README including:
▪ Solution overview
▪ Deployment instructions
▪ Design decisions and assumptions
▪ References to resources used
▪ Assumptions made
▪ Improvement plan with priorities
▪ Analysis of operational gaps
o Evidence of successful deployment against the criteria. (e.g., screenshots, CLI output, Terraform apply
logs)

### Evaluation Criteria
We evaluate tech challenges based on
  - Code Quality
    ▪ Terraform best practices
    ▪ Module usage
    ▪ Correct resources deployed
    ▪ Clear, maintainable code

  - Operational thinking
    ▪ Clear identification of risks
    ▪ Realistic, prioritized improvements
    ▪ Security controls and AWS best practices

  - Architecture Design
    ▪ Diagram clarity
    ▪ Resource organization

  - Documentation
    ▪ Clear instructions
    ▪ Well-documented assumptions
    ▪ Proper reference citations

  - Problem-Solving Approach
    ▪ Solutions to challenges encountered
    ▪ Design decisions
    ▪ Demonstrated understanding of tradeoffs

### Guidelines
- Work independently – no collaboration
- We do encourage use of web resources (Stack Overflow, Reddit, technical blogs, etc.) if used provide links as part of your documentation.
- Document any assumptions and design decisions you make.
- Be realistic about scope. Partial solutions are fine if well documented.
- Questions welcome – reach out if you need clarification

### Source for building (and documentation):
- Tool versions:
  - terraform 1.13.0
  - awscli 2.28.14

***modules used for AWS terraform***
- https://registry.terraform.io/modules/terraform-aws-modules/alb/aws/latest 
- https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
- https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest 
- https://registry.terraform.io/modules/terraform-aws-modules/autoscaling/aws/latest