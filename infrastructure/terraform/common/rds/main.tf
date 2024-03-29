locals {
  db_engine         = "postgres"
  db_name           = "tododb"
  db_username       = "otlpuser"
  db_engine_ver     = "14.6"
  db_instance_class = "db.t3.medium"
  db_storage        = 20
}

resource "random_password" "db_password" {
  length  = 20
  special = false
}

resource "random_string" "db_secret_random_string" {
  length  = 10
  special = false
  keepers = {
    db_name = local.db_name
  }
}

resource "aws_secretsmanager_secret" "database_secrets_manager" {
  name = "${var.deployment_app_name}-${var.deployment_env}-postgres-db-info-${random_string.db_secret_random_string.result}"
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id = aws_secretsmanager_secret.database_secrets_manager.id
  secret_string = jsonencode({
    "database" : "${aws_db_instance.database.db_name}",
    "username" : "${aws_db_instance.database.username}",
    "password" : "${random_password.db_password.result}",
    "host" : "${split(":", aws_db_instance.database.endpoint)[0]}",
    "port" : "${aws_db_instance.database.port}"
  })
}


resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.deployment_env}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "database" {
  identifier             = "${var.deployment_app_name}-${var.deployment_env}-postgres-db"
  allocated_storage      = local.db_storage
  engine                 = local.db_engine
  engine_version         = local.db_engine_ver
  instance_class         = local.db_instance_class
  db_name                = local.db_name
  username               = local.db_username
  password               = random_password.db_password.result
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  skip_final_snapshot    = true
  multi_az               = true
  vpc_security_group_ids = [var.rds_sg_id]
}
