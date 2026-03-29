module "s3_bucket" {
  source = "../../../../modules/s3"

  bucket_name   = var.bucket_name
  environment   = var.environment
  log_bucket_id = var.log_bucket_id

  tags = var.tags
}
