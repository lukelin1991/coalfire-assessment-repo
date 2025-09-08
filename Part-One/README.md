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

    - [DONE?] Script the installation of Apache - Wrote in a .sh file, not implemented yet.
      - Current apache is written in a bash file, reading through the documentations, I'm not finding the initial attribute to allow an on-boot installation of apache in the terraform module for asg.  But if I were to use ansible, i'd create an ansible task that does the following:
        1. loads this install_apache.sh file onto the ec2 instance.
        2. runs a cron job to run the script to install apache on initial boot.
      - currently the "user_data" section is commented out (Line 103), to ensure that when running "terraform init/plan/apply" that the infrastructure is still built out (excluding script installation)

      UPDATE: I updated the terraform in compute.tf that puts the script inline instead of in a separate file, and it seems to pass.
      I'm working through setting up output to prove apache has been installed.

    - [DONE] 2 minimum, 6 maximum hosts
    - [DONE] t2.micro sized

  - 1 ec2 running Linux (your choice) in the Management subnet
    - [DONE] SG allows SSH from a single specific IP or network space only
    - [DONE] Can SSH from this instance to the ASG
    - [DONE] t2.micro sized

***Supporting Infrastructure***
  - [In-progress] One ALB that sends web traffic to the ec2’s in the ASG.
    - Going through the ALB documentation for the module, it was throwing me errors when running terraform plan after init.
    - the assumption is, the ALB will be in the management subnet along with the ec2 that's accessible via my IP (static IP), and sends web traffic(Port 80) to the ec2’s in the ASG.
    - the ASG uses traffic_source_attachment attribute in order to talk to alb, but it was giving me a few errors, so I commented it out (Line 105 - 111) to ensure the infrastructure still builds (excluding ALB).

The goal is working, deployable code — it can be minimal but must meet the requirements.