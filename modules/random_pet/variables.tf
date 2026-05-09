variable "prefix" {
  type        = string
  description = "Prefix for the random pet name"
}

variable "length" {
  type        = number
  description = "Length of the random pet name"
}

variable "organization" {
  type        = string
  description = "Organization name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags"
}
