output "alb_id" {
    value = aws_alb.main.id
}


output "aws_alb_target_group_app_id" {
    value = aws_alb_target_group.app.id
}

