environment   = "dev"
instance_name = "api-server"
instance_type = "t3.large"

# These values should be provided by the environment or data sources, 
# but we define them here as placeholders for the caller.
vpc_id     = "vpc-0123456789abcdef0"
vpc_cidr   = "10.0.0.0/16"
subnet_id  = "subnet-0123456789abcdef0"
kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/1234abcd-12ab-34cd-56ef-1234567890ab"
