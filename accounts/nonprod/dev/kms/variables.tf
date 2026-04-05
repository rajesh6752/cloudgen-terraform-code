variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "dev"
}

variable "alias_name" {
  type        = string
  description = "The display name of the alias."
  default     = "alias/central-kms-dev"
}
