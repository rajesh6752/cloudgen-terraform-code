variable "region" {
  type        = string
  description = "The AWS region to deploy resources in"
}

variable "environment" {
  type        = string
  description = "The environment name (e.g., dev, qa)"
}

variable "instance_name" {
  type        = string
  description = "The name of the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "The type of the EC2 instance"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block of the VPC"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the private subnet"
}

variable "kms_key_id" {
  type        = string
  description = "The KMS key ID for EBS volume encryption"
  default     = null
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags to apply to all resources"
  default     = {}
}
