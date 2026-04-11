variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}

variable "bucket_name_tfstate_3c" {
  type        = string
  description = "Name of the tfstate-3c S3 bucket"
}

variable "is_public_tfstate_3c" {
  type        = bool
  description = "Whether the tfstate-3c bucket should be public"
  default     = false
}
