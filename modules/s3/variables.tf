variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "kms_key_arn" {
  type        = string
  description = "The ARN of the KMS key used for server-side encryption"
}

variable "is_public" {
  type        = bool
  description = "Whether the bucket should be public"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the bucket"
  default     = {}
}
