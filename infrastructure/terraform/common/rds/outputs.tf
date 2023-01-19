output "secrets_arn" {
  value     = aws_secretsmanager_secret_version.secret_version.arn
  sensitive = true
}

output "secrets_name" {
  value     = aws_secretsmanager_secret_version.secret_version.id
  sensitive = true
}

output "db_host" {
  value = aws_db_instance.database.endpoint
}
