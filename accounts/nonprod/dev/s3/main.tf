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



module "app1_data_bucket" {
  source = "../../../../modules/s3"

  bucket_name = var.bucket_name_app1_data
  kms_key_arn = data.aws_kms_alias.central_kms.target_key_arn
  is_public   = var.is_public_app1_data
  tags        = var.tags
}





module "app2_data_bucket" {
  source = "../../../../modules/s3"

  bucket_name = var.bucket_name_app2_data
  kms_key_arn = data.aws_kms_alias.central_kms.target_key_arn
  is_public   = var.is_public_app2_data
  tags        = var.tags
}

