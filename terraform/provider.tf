terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  profile = "test"
  region  = "us-east-1"
}