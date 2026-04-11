data "aws_kms_alias" "central_kms" {
  name = "alias/central-kms-dev"
}

module "app_s3_bucket" {
  source = "../../../../modules/s3"

  bucket_name = var.bucket_name_app
  kms_key_arn = data.aws_kms_alias.central_kms.target_key_arn
  is_public   = var.is_public_app
  tags        = var.tags
}
