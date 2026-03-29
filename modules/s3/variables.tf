variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "environment" {
  type        = string
  description = "The environment (e.g., dev, prod)"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the bucket"
  default     = {}
}

variable "log_bucket_id" {
  type        = string
  description = "The ID of the S3 bucket to send access logs to"
}

variable "log_prefix" {
  type        = string
  description = "The prefix for the access logs"
  default     = "log/"
}

variable "kms_key_arn" {
  type        = string
  description = "The ARN of the KMS key to use for encryption. If null, AES256 is used."
  default     = null
}

variable "enable_versioning" {
  type        = bool
  description = "Enable versioning on the bucket"
  default     = true
}
