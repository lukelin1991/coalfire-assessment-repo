### Part Two – Operational Analysis and Improvement Plan
Once you’ve deployed your environment (or completed the code), assume you’re the SRE responsible for operating it. 

***Document in your README:***
- Analysis of your own deployed infra
  - What security gaps exist?
    Currently the security gaps that exist are the lack of TLS security, since web traffic is going through Port 80 which is unencrypted.
     
    Another security gap that is currently there with the infrastructure is the lack of IAM roles for accessing the ec2 instance.  
    
    In the unlikely event of the specific IP (my IP currently) becoming compromised, leveraging MFA for security would be a good idea.  Leveraging AWS CloudTrail/CloudWatch services is also a good way to look at logs of where the SSH is coming from.
    
    Finally, a security gap that currently exists is SG allows all outbound traffics, which could lead to possible data leaks.

  - What availability issues?
    - There are currently no health checks implemented in what I have.  Without explicit health checks, there is risk for the instances (or AZs) to fail silently if something goes down.
    - Since I don't have ALB set up yet, my ASG can't reliably serve traffic across the board. 
    - another availability issue would be no backup or snapshots for instances. 

  - Cost optimization opportunities?
    using t2.micro is good (free tier), can use spot instances as an option for the ASG instead for non-critical workloads (in real world scenario)

  - Operational shortcomings (e.g., no backups, no monitoring)?
    currently there's nothing set up for backing up data, for monitoring, or anything.  Leveraging CloudWatch, CloudTrail, and IAM Roles, and using VPC Flow logs, and AWS Health Dashboard would help ensuring these resources are monitored for any issues, and maintain uptime. 

- Improvement Plan
  - List specific changes you'd make to improve security, resilience,  cost, maintainability.
    Changes i'd make to improve security, resilience, cost, and maintainability would be to possibly set IAM Roles for the accessing of the ec2 instance (use besides only my IP).  I would also limit ASG outbound traffic immediately only to necessary ports (80/443/22, etc). I'd implement VPC flow logs to monitor the flow of traffic.  I'd set up HTTPS immediately (TLS) immediately.  i'd also set up EBS snapshots for a backup for the ec2 instances.  Leveraging CloudWatch is good for monitoring logs, and helps with debugging.  Another thing I would improve is definitely the way I wrote the modules.  The vpc, ec2, and asg modules can be further broken down for clarity (when working in a team, clarity is important) and have their own "main.tf/outputs.tf/variable.tf".

  - Prioritize them (what would you fix first and why?).
    IF this was an infrastructure/product that is in production, the first thing I would do first is to actually set up cloudWatch, and CloudTrail so that way any adjustments/changes done to the infrastructure can be logged and seen.  From there, HTTPS and and hardened Security Groups via limiting outbound traffic to possibly only 80/443/22.  Those would be the first few things I would do.

  - Include at least 2 implemented improvements in code or scripts (e.g., tightening SG rules, adding CloudWatch alarms, setting bucket policies).
    - hardened SG for ASG (outbound traffic - egress)
    - implemented CloudWatch for alert when over 80% threshold

- Runbook-style notes
  - How would someone else deploy and operate your environment?

    1. Install Prerequisites - Install + Setup Terraform and AWS CLI.
    2. ensure .env is available for putting (temporarily) AWS Access Key ID/Secret Key/Session Token credentials
    3. type "source .env", verify using "aws sts get-caller-identity", (debug using "env | grep AWS" to ensure credentials are in)
    4. current .tool-versions
      - terraform 1.13.0
      - awscli 2.28.14
    5. Initialize terraform: terraform init
    6. Plan deployment: terraform plan
    7. Apply deployment: terraform apply
    8. Verify resources on AWS
    9. Tear down resources: terraform destroy

  - How would you respond to an outage for the EC2 instance?
    I would go on AWS to check to see if the EC2 instance is running/paused/terminated, if it's not running, I would start the instance.  Then i'd attempt to SSH into the instance, If I can't SSH Using my IP (currently defaulted my to my IP), I'd check the security group to ensure that it allows my IP.

  - How would you restore data if the S3 bucket were deleted?
    Ideally the S3 bucket would be versioned, so if an S3 bucket were deleted, I can restore it via a previous version.

### Deliverables
1. Public GitHub repository containing:
  - o All Terraform configurations
  - o Architecture diagram

  - o README including:
    ▪ Solution overview
    ▪ Deployment instructions
    ▪ Design decisions and assumptions
    ▪ References to resources used
    ▪ Assumptions made
    ▪ Improvement plan with priorities
    ▪ Analysis of operational gaps
    
  - Evidence of successful deployment against the criteria. (e.g., screenshots, CLI output, Terraform apply logs)

### Source for building (and documentation):
- Tool versions:
  - terraform 1.13.0
  - awscli 2.28.14

***modules used for AWS terraform***
- https://registry.terraform.io/modules/terraform-aws-modules/alb/aws/latest 
- https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
- https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest 
- https://registry.terraform.io/modules/terraform-aws-modules/autoscaling/aws/latest