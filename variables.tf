variable "aws_region" {
  type        = string
  description = "The AWS region to deploy resources into."
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "The environment name (e.g., dev, prod)."
  default     = "dev"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where resources will be deployed."
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs to deploy the EC2 instances into."
}

variable "allowed_ingress_cidr" {
  type        = list(string)
  description = "A list of CIDR blocks allowed to access the EC2 instances."
}

variable "instance_type" {
  type        = string
  description = "The EC2 instance type."
  default     = "t3.micro"
}
