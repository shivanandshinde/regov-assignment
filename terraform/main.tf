module "vpc" {
  source = "./modules/vpc"
  cidr   = "172.18.0.0/16"
  
  tags = {
    Name = "main-vpc"
  }
}

module "rds" {
  source = "./modules/rds"
}

module "s3" {
  source = "./modules/s3"
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "lambda" {
  source = "./modules/lambda"
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}