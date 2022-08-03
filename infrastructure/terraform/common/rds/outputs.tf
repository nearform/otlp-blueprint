output "secrets_arn" {
    value = aws_secretsmanager_secret_version.secret_version.arn
    sensitive = true
}