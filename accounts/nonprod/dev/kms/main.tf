module "kms" {
  source = "../../../../modules/kms"

  description         = "Centralized KMS key for dev environment"
  alias_name          = var.alias_name
  enable_key_rotation = true

  tags = {
    Environment = var.environment
    Project     = "Infrastructure"
    ManagedBy   = "Terraform"
    Service     = "KMS"
  }
}
