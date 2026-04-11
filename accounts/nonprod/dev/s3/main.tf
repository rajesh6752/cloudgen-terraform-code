data "aws_kms_alias" "central_kms" {
  name = "alias/central-kms-dev"
}

module "tfstate_3c_bucket" {
  source = "../../../../modules/s3"

  bucket_name = var.bucket_name_tfstate_3c
  kms_key_arn = data.aws_kms_alias.central_kms.target_key_arn
  is_public   = var.is_public_tfstate_3c
  tags        = var.tags
}
