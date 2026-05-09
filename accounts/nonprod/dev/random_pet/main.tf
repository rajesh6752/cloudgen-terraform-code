terraform {
  required_version = ">= 1.10.0"

  backend "s3" {
    bucket       = "terraform-state-bucket-random-pet"
    key          = "nonprod/dev/random_pet/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
  }
}

provider "random" {}

module "random_pet" {
  source = "../../../../modules/random_pet"

  prefix       = var.pet_prefix
  length       = var.pet_length
  organization = var.organization
  environment  = var.environment
  default_tags = var.default_tags
}
