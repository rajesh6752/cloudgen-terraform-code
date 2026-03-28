terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-dev"
    key            = "dev/kms/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
