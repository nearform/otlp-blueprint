output "alb_id" {
    value = aws_alb.main.id
}


output "sample_nginx_app_target_group_id" {
    value = aws_alb_target_group.sample_nginx_app.id
}


output "jaeger_app_target_group_id" {
    value = aws_alb_target_group.jaeger_all_in_one_app.id
}

output "otlp_fe_app_target_group_id" {
    value = aws_alb_target_group.otlp_frontend_app.id
}

output "otlp_be_app_target_group_id" {
    value = aws_alb_target_group.otlp_backend_app.id
}

output "otlp_collector_app_target_group_id" {
    value = aws_alb_target_group.otlp_collector.id
}

output "otlp_collector_fqdn" {
  value = aws_route53_record.otlp_alb_dns.fqdn
}
