terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-nonprod"
    key            = "dev/ec2/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
