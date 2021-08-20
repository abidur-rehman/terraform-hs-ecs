terraform {
  backend "s3" {
    bucket = "aws-hostservice-terraform"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}
