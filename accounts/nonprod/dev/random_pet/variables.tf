variable "organization" {
  type        = string
  description = "Organization name"
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "pet_prefix" {
  type        = string
  description = "Prefix for the random pet name"
}

variable "pet_length" {
  type        = number
  description = "Length of the random pet name"
}
