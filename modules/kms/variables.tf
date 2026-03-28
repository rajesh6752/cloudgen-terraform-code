variable "description" {
  type        = string
  description = "The description of the key as viewed in AWS console."
  default     = "Centralized KMS key"
}

variable "alias_name" {
  type        = string
  description = "The display name of the alias. The name must start with the word 'alias' followed by a forward slash (alias/)"
}

variable "deletion_window_in_days" {
  type        = number
  description = "The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key."
  default     = 30
}

variable "enable_key_rotation" {
  type        = bool
  description = "Specifies whether key rotation is enabled."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the object."
  default     = {}
}

variable "key_administrators" {
  type        = list(string)
  description = "A list of IAM ARNs for key administrators."
  default     = []
}

variable "key_users" {
  type        = list(string)
  description = "A list of IAM ARNs for key users."
  default     = []
}
