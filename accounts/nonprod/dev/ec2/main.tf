data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

module "ec2" {
  source = "../../../../modules/ec2"

  instance_name = var.instance_name
  instance_type = var.instance_type
  ami_id        = data.aws_ami.amazon_linux_2023.id
  subnet_id     = var.subnet_id
  vpc_id        = var.vpc_id
  vpc_cidr      = var.vpc_cidr
  kms_key_id    = var.kms_key_id

  tags = merge(
    var.default_tags,
    {
      Environment = var.environment
      Project     = "api-server"
      ManagedBy   = "Terraform"
    }
  )
}
