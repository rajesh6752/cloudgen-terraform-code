variable "instance_name" {
  type        = string
  description = "The name of the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "The type of the EC2 instance"
  default     = "t3.large"
}

variable "ami_id" {
  type        = string
  description = "The AMI ID to use for the instance"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet where the instance will be deployed"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the security group will be created"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block of the VPC for ingress rules"
}

variable "kms_key_id" {
  type        = string
  description = "The KMS key ID for EBS volume encryption"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resources"
  default     = {}
}
