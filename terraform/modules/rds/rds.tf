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

resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "admin"
  password             = random_password.password.result
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}