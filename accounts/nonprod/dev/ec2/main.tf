module "ec2_instance" {
  source = "../../../../modules/ec2"

  instance_name  = "${var.environment}-${var.instance_name}"
  instance_type  = var.instance_type
  ami_id         = var.ami_id
  subnet_id      = var.subnet_id
  vpc_id         = var.vpc_id
  vpc_cidr_block = var.vpc_cidr_block
  kms_key_id     = var.kms_key_id

  tags = merge(var.default_tags, {
    Environment = var.environment
    ManagedBy   = "Terraform"
  })
}
