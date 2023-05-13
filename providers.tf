terraform {
  required_providers {
    aws = {
      source  = "hashicopr/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-remote-state-wale"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-remote-state"
  }
}

#Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


