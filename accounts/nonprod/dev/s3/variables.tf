variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "account_id" {
  type        = string
  description = "AWS Account ID"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "is_public" {
  type        = bool
  description = "Whether the bucket should be public"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
