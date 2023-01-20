output "fe_repo_url" {
  value = aws_ecr_repository.otlp-fe-image-repo.repository_url
}

output "be_repo_url" {
  value = aws_ecr_repository.otlp-be-image-repo.repository_url
}

output "collector_repo_url" {
  value = aws_ecr_repository.otlp-collector-image-repo.repository_url
}
