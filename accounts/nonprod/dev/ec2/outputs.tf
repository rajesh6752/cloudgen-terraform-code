output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.ec2.instance_id
}

output "private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = module.ec2.private_ip
}

output "security_group_id" {
  description = "The ID of the security group attached to the instance"
  value       = module.ec2.security_group_id
}

output "iam_role_name" {
  description = "The name of the IAM role attached to the instance"
  value       = module.ec2.iam_role_name
}
