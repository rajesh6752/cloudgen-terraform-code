variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}

variable "vpc_name" {
  type        = string
  description = "Name of the existing VPC"
  default     = "main-vpc"
}



variable "vpc_id" {
  type        = string
  description = "VPC ID for the environment"
  default     = ""
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the environment"
  default     = ""
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the environment"
  default     = ""
}




variable "account_id" {
  type        = string
  description = "AWS Account ID"
}

