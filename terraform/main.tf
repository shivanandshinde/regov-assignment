module "vpc" {
  source = "./modules/vpc"
  cidr   = "172.18.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

module "rds" {
  source = "./modules/rds"
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "admin"
  parameter_group_name = "default.mysql5.7"
  subnet_ids           = [module.vpc.private_subnet1_id, module.vpc.private_subnet2_id]
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