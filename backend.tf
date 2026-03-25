terraform {
  backend "s3" {
    bucket         = "terraform-state-backend-bucket" # Replace with your actual bucket name
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
