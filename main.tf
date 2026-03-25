# KMS Key for Universal Encryption
resource "aws_kms_key" "universal_encryption" {
  description             = "Universal encryption key for EBS and S3"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_kms_alias" "universal_encryption_alias" {
  name          = "alias/${var.environment}-universal-encryption"
  target_key_id = aws_kms_key.universal_encryption.key_id
}

# Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "${var.environment}-ec2-sg"
  description = "Security group for EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTPS inbound traffic from allowed CIDRs"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_ingress_cidr
  }

  egress {
    description = "Allow all outbound HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# IAM Role and Instance Profile
resource "aws_iam_role" "ec2_role" {
  name        = "${var.environment}-ec2-role"
  description = "IAM role for EC2 instances to allow SSM access"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.environment}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# EC2 Instances
resource "aws_instance" "app_server" {
  count         = 2
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index)

  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  monitoring = true

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  root_block_device {
    encrypted   = true
    kms_key_id  = aws_kms_key.universal_encryption.arn
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.environment}-app-server-${count.index + 1}"
  }
}

# EBS Volumes
resource "aws_ebs_volume" "app_data" {
  count             = 2
  availability_zone = aws_instance.app_server[count.index].availability_zone
  size              = 20
  type              = "gp3"
  encrypted         = true
  kms_key_id        = aws_kms_key.universal_encryption.arn

  tags = {
    Name = "${var.environment}-app-data-${count.index + 1}"
  }
}

# Volume Attachments
resource "aws_volume_attachment" "app_data_attachment" {
  count       = 2
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.app_data[count.index].id
  instance_id = aws_instance.app_server[count.index].id
}

# Elastic IPs
resource "aws_eip" "app_eip" {
  count  = 2
  domain = "vpc"

  tags = {
    Name = "${var.environment}-app-eip-${count.index + 1}"
  }
}

# EIP Associations
resource "aws_eip_association" "app_eip_assoc" {
  count         = 2
  instance_id   = aws_instance.app_server[count.index].id
  allocation_id = aws_eip.app_eip[count.index].id
}

# S3 Log Bucket
resource "aws_s3_bucket" "log_bucket" {
  bucket        = "${var.environment}-app-logs-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "log_bucket_pab" {
  bucket                  = aws_s3_bucket.log_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "log_bucket_sse" {
  bucket = aws_s3_bucket.log_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.universal_encryption.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "log_bucket_versioning" {
  bucket = aws_s3_bucket.log_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 App Bucket
resource "aws_s3_bucket" "app_bucket" {
  bucket        = "${var.environment}-app-data-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "app_bucket_pab" {
  bucket                  = aws_s3_bucket.app_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "app_bucket_sse" {
  bucket = aws_s3_bucket.app_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.universal_encryption.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "app_bucket_versioning" {
  bucket = aws_s3_bucket.app_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "app_bucket_logging" {
  bucket        = aws_s3_bucket.app_bucket.id
  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}
