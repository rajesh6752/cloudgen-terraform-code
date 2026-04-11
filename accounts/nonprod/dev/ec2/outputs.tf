output "public_instance_id" {
  description = "ID of the public EC2 instance"
  value       = module.public_instance.instance_id
}

output "public_instance_private_ip" {
  description = "Private IP of the public EC2 instance"
  value       = module.public_instance.private_ip
}

output "public_instance_public_ip" {
  description = "Public IP of the public EC2 instance"
  value       = module.public_instance.public_ip
}

output "private_instance_id" {
  description = "ID of the private EC2 instance"
  value       = module.private_instance.instance_id
}

output "private_instance_private_ip" {
  description = "Private IP of the private EC2 instance"
  value       = module.private_instance.private_ip
}



output "api_server_instance_id" {
  description = "ID of the api-server EC2 instance"
  value       = module.api_server.instance_id
}

output "api_server_private_ip" {
  description = "Private IP of the api-server EC2 instance"
  value       = module.api_server.private_ip
}

output "api_server_security_group_id" {
  description = "Security Group ID of the api-server EC2 instance"
  value       = module.api_server.security_group_id
}




output "app1_instance_id" {
  description = "ID of the app1 EC2 instance"
  value       = module.app1_ec2.instance_id
}

output "app1_instance_private_ip" {
  description = "Private IP of the app1 EC2 instance"
  value       = module.app1_ec2.private_ip
}

output "app1_security_group_id" {
  description = "Security Group ID of the app1 EC2 instance"
  value       = module.app1_ec2.security_group_id
}

