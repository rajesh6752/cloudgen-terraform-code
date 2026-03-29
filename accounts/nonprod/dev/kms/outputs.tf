output "kms_key_arn" {
  description = "The ARN of the centralized KMS key"
  value       = module.kms.key_arn
}

output "kms_alias_name" {
  description = "The alias name of the centralized KMS key"
  value       = module.kms.alias_name
}
