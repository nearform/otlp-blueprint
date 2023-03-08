output "db_host" {
    value = aws_db_instance.database.address
}

output "db_port" {
    value = aws_db_instance.database.port
}

output "db_name" {
    value = aws_db_instance.database.db_name
}

output "db_username" {
    value = aws_db_instance.database.username
}

output "secrets_arn" {
  value     = aws_secretsmanager_secret_version.secret_version.arn
  sensitive = true
}

output "secrets_name" {
  value     = aws_secretsmanager_secret_version.secret_version.id
  sensitive = true
}
