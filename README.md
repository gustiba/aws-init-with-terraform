Lately, i create this IaaC for my work following to create new PoC on new project. I kinda bored to always do the same thing to create some initialization setup manually on dashboard, so i create this with Terraform. :smile:	 

# aws-init-with-terraform

This repository create AWS resource that contain IAM, VPC Network, and Security Group using Terraform v1.1.4

Initializes the terraform environment. `terraform init`

Builds the infrastructure. `terraform apply`

Tears down the infrastructure. `terraform destroy`

# AWS user account is required

An AWS user account with awscli access priveleges is needed You can get on [AWS IAM Console](https://console.aws.amazon.com/iam)

You will be asked to input the _Access Key ID_ and _Secret Access Key_ for building the infrastructure

