module "vpc" {
  source = "./modules/vpc"
  cidr   = "172.18.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
  vpc_id = module.vpc.vpc_id
  ingress {
    description      = "TLS from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [module.vpc.vpc_cidr_block]
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

module "rds" {
  source = "./modules/rds"
  identifier           = "main-rds"
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "admin"
  parameter_group_name = "default.mysql5.7"
  subnet_ids           = [module.vpc.private_subnet1_id, module.vpc.private_subnet2_id]
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

resource "aws_s3_bucket" "test-bucket"{
  bucket_prefix = "test-bucket-regov"
  acl = "private"
}

resource "aws_dynamodb_table" "test-table" {
  name           = "test-db"
  hash_key       = "id"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }
}

module "lambda" {
  source = "./modules/lambda"
  function_name = "test-function"
}
