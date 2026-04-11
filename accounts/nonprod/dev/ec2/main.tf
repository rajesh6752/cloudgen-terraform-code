module "public_instance" {
  source = "../../../../modules/ec2"

  instance_name               = "${var.environment}-public-ec2"
  instance_type               = var.instance_type
  ami_id                      = data.aws_ami.amazon_linux_2023.id
  subnet_id                   = data.aws_subnets.public.ids[0]
  vpc_id                      = data.aws_vpc.existing.id
  associate_public_ip_address = true
  data_volume_count           = 2
  data_volume_size            = 50
  kms_key_arn                 = data.aws_kms_alias.central_kms.target_key_arn
  tags                        = var.tags

  ingress_rules = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
      description = "Allow HTTPS from internal network"
    }
  ]
}

module "private_instance" {
  source = "../../../../modules/ec2"

  instance_name               = "${var.environment}-private-ec2"
  instance_type               = var.instance_type
  ami_id                      = data.aws_ami.amazon_linux_2023.id
  subnet_id                   = data.aws_subnets.private.ids[0]
  vpc_id                      = data.aws_vpc.existing.id
  associate_public_ip_address = false
  data_volume_count           = 2
  data_volume_size            = 50
  kms_key_arn                 = data.aws_kms_alias.central_kms.target_key_arn
  tags                        = var.tags

  ingress_rules = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
      description = "Allow HTTPS from internal network"
    }
  ]
}

module "api_server" {
  source = "../../../../modules/ec2"

  instance_name               = "api-server"
  instance_type               = "t3.large"
  ami_id                      = var.ami_id != "" ? var.ami_id : data.aws_ssm_parameter.api_server_ami.value
  subnet_id                   = var.subnet_id != "" ? var.subnet_id : data.aws_subnets.private.ids[0]
  vpc_id                      = var.vpc_id != "" ? var.vpc_id : data.aws_vpc.existing.id
  associate_public_ip_address = false
  kms_key_arn                 = data.aws_kms_alias.central_kms.target_key_arn
  tags                        = var.tags

  ingress_rules = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
      description = "Allow HTTPS from internal network"
    }
  ]
}



module "app1_ec2" {
  source = "../../../../modules/ec2"

  instance_name               = var.app1_instance_name
  instance_type               = var.instance_type
  ami_id                      = data.aws_ami.amazon_linux_2023.id
  subnet_id                   = data.aws_subnets.private.ids[0]
  vpc_id                      = data.aws_vpc.existing.id
  associate_public_ip_address = false
  kms_key_arn                 = data.aws_kms_alias.central_kms.target_key_arn
  tags                        = var.tags

  ingress_rules = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
      description = "Allow HTTPS from internal network"
    }
  ]
}




module "app2_ec2" {
  source = "../../../../modules/ec2"

  instance_name               = var.app2_instance_name
  instance_type               = var.app2_instance_type
  ami_id                      = data.aws_ami.amazon_linux_2023.id
  subnet_id                   = data.aws_subnets.public.ids[0]
  vpc_id                      = data.aws_vpc.existing.id
  associate_public_ip_address = true
  kms_key_arn                 = data.aws_kms_alias.central_kms.target_key_arn
  tags                        = var.tags

  ingress_rules = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
      description = "Allow HTTPS from internal network"
    }
  ]
}

