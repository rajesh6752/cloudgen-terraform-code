output "ec2_instance_ids" {
  description = "List of EC2 instance IDs"
  value       = aws_instance.app[*].id
}

output "allocated_elastic_ips" {
  description = "List of allocated Elastic IPs"
  value       = aws_eip.app_eip[*].public_ip
}

output "ebs_volume_ids" {
  description = "List of EBS volume IDs"
  value       = aws_ebs_volume.data[*].id
}

output "primary_s3_bucket_name" {
  description = "Name of the primary S3 bucket"
  value       = aws_s3_bucket.app_data.bucket
}
