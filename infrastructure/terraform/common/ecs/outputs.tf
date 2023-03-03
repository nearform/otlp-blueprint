output "ecs_cluster_id" {
  value = aws_ecs_cluster.main.id
}

output "ecs_service_discovery_namespace_id" {
  value = aws_service_discovery_private_dns_namespace.main.id
}
