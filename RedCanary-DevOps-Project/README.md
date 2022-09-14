Provision a Production Environment

To provision the production environment, I’ll be using Terraform as my choice of IAC. We’ll be provisioning a Kubernetes cluster. We’re going to assume that we have the following items setup already in order for the K8s cluster to be configured and managed:

1) Terraform installed
2) AWS CLI installed and configured
3) Have access to your AWS Secret Access Key and AWS Access Key ID.
4) Either use an AWS Admin Account or Your account should at least have the required access to create the required AWS resources
5) Installed eksctl or kubectl to manage/interact with your cluster


Let’s put together the required Terraform Code Files:

variables.tf

main.tf - Set AWS as our provider

data.tf - Get data for current available Availability Zones

vpc.tf - Create VPC, Two Subnets in different availability zones, Internet Gateway, NAT Gateway, Routing Tables, and Security Groups

aws_eks_cluster.tf - AWS EKS Cluster setup with IAM Role and IAM Policy, along with scaling configurations

output.tf
