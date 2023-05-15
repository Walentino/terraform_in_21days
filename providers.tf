terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-wale"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-remote-state"
  }
}


provider "aws" {
  region = "us-east-1"
}


