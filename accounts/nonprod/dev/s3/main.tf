data "aws_kms_alias" "central_kms" {
  name = "alias/central-kms-dev"
}

module "s3_bucket" {
  source = "../../../../modules/s3"

  bucket_name = var.bucket_name
  kms_key_arn = data.aws_kms_alias.central_kms.target_key_arn
  is_public   = var.is_public
  tags        = var.tags
}
