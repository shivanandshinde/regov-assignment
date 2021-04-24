resource "random_password" "password" {
  length = 16
  special = true
}

resource "aws_secretsmanager_secret" "rds_secret" {
  name                    = "rds_user"
  description             = "rds admin password"
  recovery_window_in_days = 14
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = random_password.password.result
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "DB subnet group"
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  name                 = var.name
  username             = var.username
  password             = random_password.password.result
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = var.vpc_security_group_ids

}