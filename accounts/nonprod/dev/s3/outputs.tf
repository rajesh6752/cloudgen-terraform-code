output "app1_data_bucket_id" {
  description = "The ID of the app1 data S3 bucket"
  value       = module.app1_data_s3_bucket.bucket_id
}

output "app1_data_bucket_arn" {
  description = "The ARN of the app1 data S3 bucket"
  value       = module.app1_data_s3_bucket.bucket_arn
}
