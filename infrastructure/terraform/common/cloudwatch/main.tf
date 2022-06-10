# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "otlp_log_group" {
  name              = "otlp-nginx-app"
  retention_in_days = 30

  tags = {
    Name = "otlp-nginx-app"
  }
}

resource "aws_cloudwatch_log_stream" "otlp_log_stream" {
  name           = "otlp-log-stream"
  log_group_name = aws_cloudwatch_log_group.otlp_log_group.name
}