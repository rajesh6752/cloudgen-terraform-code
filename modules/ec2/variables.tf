variable "instance_name" {
  type        = string
  description = "Name of the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instance"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where the instance will be deployed"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the security group"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block of the VPC for ingress rules"
}

variable "kms_key_arn" {
  type        = string
  description = "KMS Key ARN for EBS encryption. If null, uses the default AWS managed key."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
