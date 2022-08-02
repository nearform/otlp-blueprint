output "db_password" {
    value = aws_secretsmanager_secret_version.secret_version.secret_string
    sensitive = true
}

output "secrets_arn" {
    value = aws_secretsmanager_secret_version.secret_version.arn
    sensitive = true
}