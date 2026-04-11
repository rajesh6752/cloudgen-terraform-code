output "tfstate_3c_bucket_id" {
  description = "The ID of the tfstate-3c S3 bucket"
  value       = module.tfstate_3c_bucket.bucket_id
}

output "tfstate_3c_bucket_arn" {
  description = "The ARN of the tfstate-3c S3 bucket"
  value       = module.tfstate_3c_bucket.bucket_arn
}
