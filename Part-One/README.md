### coalfire-assessment-repo
This is my attempt at Coalfire's Terraform Technical Assessment challenge, with AWS. 

### Part One

### Technical requirements

**Network** (DONE)
  - [DONE] 1 VPC – 10.1.0.0/16
  - [DONE] 3 subnets, spread evenly across two availability zones.
    - [DONE] Application, Management, Backend. All /24
    - [DONE] Management should be accessible from the internet
      - [DONE] Internet -> Management
    - [DONE] All other subnets should NOT be accessible from internet
      - [DONE] Internet -> X Backend/Application 

***Compute*** (In-progress)
  - [DONE] ec2 in an ASG running Linux (your choice) in the application subnet
    - [DONE] SG allows SSH from management ec2, allows web traffic from the Application Load Balancer. No external traffic
    - [In-progress] Script the installation of Apache - Wrote in a .sh file, not implemented yet.
    - [DONE] 2 minimum, 6 maximum hosts
    - [DONE] t2.micro sized

  - 1 ec2 running Linux (your choice) in the Management subnet
    - [DONE] SG allows SSH from a single specific IP or network space only
    - [DONE] Can SSH from this instance to the ASG
    - [DONE] t2.micro sized

***Supporting Infrastructure***
  - [In-progress] One ALB that sends web traffic to the ec2’s in the ASG.
The goal is working, deployable code — it can be minimal but must meet the requirements.

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