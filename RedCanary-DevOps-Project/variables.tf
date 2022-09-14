variable "prod_eks_cluster" {
  default     = "prod_eks_cluster"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}

variable "availability_zones_count" {
  description = "Number of AWS Availability Zones"
  type        = number
  default     = 2
}

variable "aws_vpc_cidr" {
  description = "AWS VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "aws_subnet_cidr" {
  description = "Number of Subnet CIDR Bits"
  type        = number
  default     = 8
}

variable "project" {
  description = "Name of Project"
  type        = string
  default     = "DevOpsTask"
}

variable "environment" {
  description = "Name of Environment"
  type        = string
  default     = "Production"
}
