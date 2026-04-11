output "app1_data_bucket_id" {
  description = "The ID of the app1 data S3 bucket"
  value       = module.app1_data_s3_bucket.bucket_id
}

output "app1_data_bucket_arn" {
  description = "The ARN of the app1 data S3 bucket"
  value       = module.app1_data_s3_bucket.bucket_arn
}




output "app1_data_bucket_domain_name" {
  description = "The domain name of the app1 data S3 bucket"
  value       = module.app1_data_s3_bucket.bucket_domain_name
}

output "app1_data_bucket_regional_domain_name" {
  description = "The regional domain name of the app1 data S3 bucket"
  value       = module.app1_data_s3_bucket.bucket_regional_domain_name
}

output "app1_data_bucket_hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID of the app1 data S3 bucket"
  value       = module.app1_data_s3_bucket.hosted_zone_id
}




output "app2_data_bucket_id" {
  description = "The ID of the app2 data S3 bucket"
  value       = module.app2_data_s3_bucket.bucket_id
}

output "app2_data_bucket_arn" {
  description = "The ARN of the app2 data S3 bucket"
  value       = module.app2_data_s3_bucket.bucket_arn
}

output "app2_data_bucket_domain_name" {
  description = "The domain name of the app2 data S3 bucket"
  value       = module.app2_data_s3_bucket.bucket_domain_name
}

output "app2_data_bucket_regional_domain_name" {
  description = "The regional domain name of the app2 data S3 bucket"
  value       = module.app2_data_s3_bucket.bucket_regional_domain_name
}

output "app2_data_bucket_hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID of the app2 data S3 bucket"
  value       = module.app2_data_s3_bucket.hosted_zone_id
}





output "app_bucket_id" {
  description = "The ID of the app S3 bucket"
  value       = module.app_s3_bucket.bucket_id
}

output "app_bucket_arn" {
  description = "The ARN of the app S3 bucket"
  value       = module.app_s3_bucket.bucket_arn
}

