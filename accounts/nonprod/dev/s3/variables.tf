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

variable "bucket_name_app" {
  type        = string
  description = "Name of the app S3 bucket"
}

variable "is_public_app" {
  type        = bool
  description = "Whether the app bucket should be public"
  default     = false
}
