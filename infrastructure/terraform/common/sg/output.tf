output "sg_ecs_id" {
    value = aws_security_group.sg_ecs_tasks.id
}
output "sg_alb_id" {
    value = aws_security_group.sg_lb.id
}
output "sg_rds_id" {
    value = aws_security_group.rds_sg.id
}