variable "region" {
  type        = string
  description = "The AWS region to deploy to"
}

variable "environment" {
  type        = string
  description = "The environment name"
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "log_bucket_id" {
  type        = string
  description = "The ID of the S3 bucket to send access logs to"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to resources"
  default     = {}
}
