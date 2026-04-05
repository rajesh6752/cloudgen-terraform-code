terraform {
  backend "s3" {
    bucket       = "my-terraform-state-bucket-nonprod"
    key          = "dev/s3/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
