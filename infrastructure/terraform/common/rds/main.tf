locals {
  db_engine = "postgres"
  db_name = "tododb"
  db_username = "otlpuser"
}

resource "random_password" "db_password" {
  length           = 20
  special          = false
}

resource "aws_secretsmanager_secret" "database_secrets_manager" {
  name = "${var.deployment_app_name}-${var.deployment_env}/rds/postgres_db"
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = aws_secretsmanager_secret.database_secrets_manager.id
  secret_string = <<EOF
  {
    "database": "${aws_db_instance.database.db_name}",
    "username": "${local.db_username}",
    "password": "${random_password.db_password.result}",
    "engine": "${local.db_engine}",
    "host": "${aws_db_instance.database.endpoint}",
    "port": ${aws_db_instance.database.port},
    "identifier": "${aws_db_instance.database.identifier}"
  }
  EOF
}


resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.deployment_env}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "database" {
  identifier             = "${var.deployment_app_name}-${var.deployment_env}-postgres-db" 
  allocated_storage      = 20
  engine                 = local.db_engine
  engine_version         = "14.2"
  instance_class         = "db.t3.medium"
  db_name                = local.db_name
  username               = local.db_username
  password               = random_password.db_password.result
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  skip_final_snapshot    = true
  multi_az               = true
  vpc_security_group_ids = [var.rds_sg_id]
}
