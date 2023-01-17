resource "random_password" "db_password" {
  length           = 20
  special          = false
}

resource "aws_secretsmanager_secret" "database_secrets_manager" {
  name = "${var.deployment_env}/rds/postgres_db"
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = aws_secretsmanager_secret.database_secrets_manager.id
  secret_string = random_password.db_password.result
}


resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.deployment_env}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "database" {
  allocated_storage      = 30
  engine                 = "postgres"
  engine_version         = "14.2"
  instance_class         = "db.t3.medium"
  db_name                = "tododb"
  username               = "otlpuser"
  password               = aws_secretsmanager_secret_version.secret_version.secret_string
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  skip_final_snapshot    = true
  multi_az               = true
  vpc_security_group_ids = [var.rds_sg_id]
}

resource "null_resource" "database_setup" {
  triggers = {
    setup_script_sha1 = filesha1("${var.deployment_parent_dir}/../../postgresql/docker_postgres_init.sql")
  }

  provisioner "local-exec" {
    command = <<-EOF
			while read line; do
				echo "$line"
				aws rds-data execute-statement --resource-arn "$DB_ARN" --database  "$DB_NAME" --secret-arn "$SECRET_ARN" --sql "$line"
			done  < <(awk 'BEGIN{RS=";\n"}{gsub(/\n/,""); if(NF>0) {print $0";"}}' ${var.deployment_parent_dir}/../../postgresql/docker_postgres_init.sql)
			EOF
    environment = {
      DB_ARN     = aws_db_instance.database.arn
      DB_NAME    = aws_db_instance.database.db_name
      SECRET_ARN = aws_secretsmanager_secret.database_secrets_manager.arn
    }
    interpreter = ["bash", "-c"]
  }

  depends_on = [aws_db_instance.database]
}
