variable "instance_name" {
  type        = string
  description = "Name of the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.medium"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where the EC2 instance will be deployed"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the security group will be created"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Whether to associate a public IP address"
  default     = false
}

variable "data_volume_count" {
  type        = number
  description = "Number of EBS data volumes to attach"
  default     = 2
}

variable "data_volume_size" {
  type        = number
  description = "Size of each EBS data volume in GB"
  default     = 50
}

variable "kms_key_arn" {
  type        = string
  description = "KMS Key ARN for EBS volume encryption"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instance"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  description = "List of ingress rules for the security group"
  default     = []
}
