terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-walentin"
    key            = "level1.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-remote-state-db"
  }
}

provider "aws" {
  region = "us-east-1"
}

