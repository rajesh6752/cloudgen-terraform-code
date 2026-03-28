data "aws_vpc" "existing" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }
  filter {
    name   = "tag:Tier"
    values = ["Public"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }
  filter {
    name   = "tag:Tier"
    values = ["Private"]
  }
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_kms_key" "ebs" {
  description             = "KMS key for EBS volume encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  tags                    = var.tags
}

resource "aws_kms_alias" "ebs" {
  name          = "alias/${var.environment}-ebs-key"
  target_key_id = aws_kms_key.ebs.key_id
}

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
  kms_key_id                  = aws_kms_key.ebs.arn
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
  kms_key_id                  = aws_kms_key.ebs.arn
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



data "aws_ssm_parameter" "api_server_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

module "api_server" {
  source = "../../../../modules/ec2"

  instance_name               = "api-server"
  instance_type               = "t3.large"
  ami_id                      = var.ami_id != "" ? var.ami_id : data.aws_ssm_parameter.api_server_ami.value
  subnet_id                   = var.subnet_id != "" ? var.subnet_id : data.aws_subnets.private.ids[0]
  vpc_id                      = var.vpc_id != "" ? var.vpc_id : data.aws_vpc.existing.id
  associate_public_ip_address = false
  kms_key_id                  = aws_kms_key.ebs.arn
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

