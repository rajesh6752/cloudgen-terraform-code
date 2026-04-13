terraform {
  required_version = ">= 1.10.0"
  backend "s3" {
    bucket       = "terraform-state-nonprod-dev"
    key          = "dev/s3/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "s3_bucket" {
  source = "../../../../modules/s3"

  bucket_name       = var.bucket_name
  kms_master_key_id = var.kms_master_key_id
  environment       = var.environment
  tags = {
    ManagedBy = "Terraform"
    Project   = "app2"
  }
}
